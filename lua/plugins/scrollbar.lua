-- ~/.config/nvim/lua/plugins/scrollbar.lua
return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "lewis6991/gitsigns.nvim",
    },
    config = function()
        require("scrollbar").setup({
            handlers = {
                diagnostic = true, -- visar LSP errors / warnings
                gitsigns = true, -- visar git changes
            },
        })
    end,
}
