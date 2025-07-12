-- Lazy.nvim Plugin Manager Setup
-- Bootstrap och konfiguration av Lazy.nvim
-- TODO: Lägg till mer dokumentation och kommentarer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Installera Lazy.nvim automatiskt om det inte finns
if not vim.loop.fs_stat(lazypath) then
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
