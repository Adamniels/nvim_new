-- VimTeX: LaTeX support for Neovim
-- Plugin: lervag/vimtex
-- Detta plugin ger smart LaTeX-editing, compilation och navigation.

return {
    "lervag/vimtex",
    ft = { "tex", "plaintex", "latex" }, -- ladda bara för LaTeX-filer
    init = function()
        -- Allmänna VimTeX-inställningar
        -- Använd Skim som PDF-viewer på macOS
        vim.g.vimtex_view_method = "skim"
        -- vim.g.vimtex_view_method = "sioyek"
        -- Standard: latexmk
        vim.g.vimtex_compiler_method = "latexmk"

        -- Skim sync (från vimtex-dokumentationen)
        -- Gör att forward/backward search fungerar bra
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1

        -- Stäng av inbyggd concealing om du inte gillar det
        -- 0 = av, 2 = ganska aggressiv (default i vimtex)
        vim.g.vimtex_syntax_conceal = {
            accents = 0,
            ligatures = 0,
            cites = 0,
            fancy = 0,
            spacing = 0,
            greek = 0,
            math_bounds = 0,
            math_delimiters = 0,
            math_fracs = 0,
            math_super_sub = 0,
            math_symbols = 0,
            sections = 0,
            styles = 0,
        }

        -------------------------------------------------------------------------
        -- Auto-compile & filetype-specifika keymaps/snippets för LaTeX
        -------------------------------------------------------------------------
        local augroup = vim.api.nvim_create_augroup("VimTeXAuto", { clear = true })

        -- Auto-compile på varje save i .tex-filer (kontinuerlig kompilering)
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            pattern = { "*.tex", "*.plaintex", "*.latex" },
            callback = function()
                -- Använd kontinuerligt läge om det inte redan körs
                vim.cmd("VimtexCompile")
            end,
        })

        -- FileType-hook för LaTeX: keymaps + enkla snippets
        vim.api.nvim_create_autocmd("FileType", {
            group = augroup,
            pattern = { "tex", "plaintex", "latex" },
            callback = function(ev)
                local bufnr = ev.buf
                local opts = { noremap = true, silent = true, buffer = bufnr }

                -- Snabb navigation/kommandon för VimTeX
                vim.keymap.set("n", "<leader>al", "<cmd>VimtexCompile<CR>", opts) -- kompilera
                vim.keymap.set("n", "<leader>av", "<cmd>VimtexView<CR>", opts)    -- öppna/uppdatera PDF
                vim.keymap.set("n", "<leader>ac", "<cmd>VimtexClean<CR>", opts)   -- städa aux-filer
                vim.keymap.set("n", "<leader>ae", "<cmd>VimtexErrors<CR>", opts)  -- visa fel

                -- Enkla "snippets" utan extra plugin (insert-mode mappings)
                vim.keymap.set("i", ";;", "\\", opts)      -- snabb backslash
                vim.keymap.set("i", "<", "<><Left>", opts) -- snabb \<...> om du vill ändra senare

                -- Vanliga LaTeX-block
                vim.keymap.set("i", "ff", "\\frac{}{}<Left><Left>", opts)
                vim.keymap.set("i", "bb", "\\textbf{}<Left>", opts)
                vim.keymap.set("i", "ii", "\\textit{}<Left>", opts)
            end,
        })
    end,
}
