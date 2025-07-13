-- Telescope Fuzzy Finder Plugin
-- En kraftfull och utbyggbar fuzzy finder för Neovim
--
-- Funktioner:
-- - Snabb filsökning med fuzzy matching
-- - Live grep för att söka text i alla filer
-- - Bufferthantering och navigation
-- - Git-integration (commits, branches, status)
-- - Kommandshistorik och hjälptext
-- - Anpassningsbara selectors och previews
-- - Stöd för extensions och custom pickers
--
-- Söktips:
-- - Använd mellanslag för att separera söktermer
-- - '!' framför ord exkluderar det från sökningen
-- - '^' i början matchar början av filnamn
-- - '$' i slutet matchar slutet av filnamn
-- - Använd path/to/ för att söka i specifik mapp
--
-- Tangentkommandon (inom Telescope):
-- - Ctrl+j/k: Navigera upp/ner i lista
-- - Ctrl+q: Skicka resultat till quickfix list
-- Ctrl+x: Öppna fil i horisontell split
-- - Enter: Öppna fil i aktuellt fönster
-- - Ctrl+v: Öppna fil i vertikal split
-- - Ctrl+t: Öppna fil i ny tab
-- - Ctrl+u/d: Scrolla preview upp/ner

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",                                  -- Lua-funktioner som Telescope behöver
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Snabbare fuzzy finding
        "nvim-tree/nvim-web-devicons",                            -- Filtypsikoner
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- Keymaps för telescope
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
        vim.keymap.set("n", "<leader>fn", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, { desc = "find in nvim" })
        vim.keymap.set("n", "<leader>fsc", builtin.current_buffer_fuzzy_find, { desc = "find string in current file" })
        vim.keymap.set("n", "<leader>fsg", builtin.live_grep, { desc = "find string in cwd(global)" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
    end,
}
