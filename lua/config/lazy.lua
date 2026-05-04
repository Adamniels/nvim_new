-- Lazy.nvim Plugin Manager Setup
-- Bootstrap och konfiguration av Lazy.nvim
-- TODO: Lägg till mer dokumentation och kommentarer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Installera Lazy.nvim automatiskt om det inte finns
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- senaste stabila release
        lazypath,
    })
end

-- Lägg till Lazy.nvim i runtime path
vim.opt.rtp:prepend(lazypath)

-- On macOS, re-sign all compiled .so files after any plugin install or update.
-- This prevents the CODESIGNING crash that occurs when a native plugin is
-- compiled without a valid ad-hoc signature for Apple Silicon.
if vim.fn.has("mac") == 1 then
    local function resign_native_plugins()
        local data = vim.fn.stdpath("data") .. "/lazy"
        vim.fn.system({ "find", data, "-name", "*.so", "-exec", "codesign", "--force", "--sign", "-", "{}", ";" })
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyInstall", "LazyUpdate" },
        callback = resign_native_plugins,
    })
end

-- Setup Lazy.nvim med plugins
require("lazy").setup({
    -- Importera alla plugins från plugins mappen
    { import = "plugins" },
    -- Importera LSP plugins
    { import = "plugins.lsp" },
}, {
    -- Lazy.nvim konfiguration
    checker = {
        enabled = true, -- Kolla efter plugin-uppdateringar automatiskt
        notify = false, -- Visa inte notifikationer om uppdateringar
    },
    change_detection = {
        notify = false, -- Visa inte notifikationer vid konfigurationsändringar
    },
})

-- Set treesitter-based folding per buffer, only after a parser is available.
-- This avoids evaluating the foldexpr globally before treesitter has loaded.
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local ok = pcall(vim.treesitter.start)
        if ok then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        else
            vim.wo.foldmethod = "indent"
        end
    end,
})
