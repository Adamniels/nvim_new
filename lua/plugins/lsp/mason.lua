return {
    {
        "williamboman/mason.nvim",               -- Installerar LSP-servrar enkelt
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- Kopplar Mason till nvim-lspconfig
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "clangd", "omnisharp", "html", "cssls", "jsonls" }, -- exempel
                automatic_enable = false,
            })
        end,
    },
}

