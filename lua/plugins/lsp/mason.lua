-- Mason LSP Installer
-- Automatisk installation och hantering av language servers, linters och formatters
--
-- Funktioner:
-- - GUI för att installera/avinstallera language servers
-- - Automatisk installation av nödvändiga verktyg
-- - Uppdateringshantering för alla verktyg
-- - Cross-platform support (Windows, macOS, Linux)
-- - Integration med nvim-lspconfig
--
-- Kommandon:
-- - :Mason - Öppna Mason UI för att hantera installationer
-- - :MasonInstall <server> - Installera specifik server
-- - :MasonUninstall <server> - Avinstallera server
-- - :MasonUpdate - Uppdatera alla installerade verktyg
--
-- Language servers som installeras automatiskt:
-- - typescript-language-server (TypeScript/JavaScript)
-- - pyright (Python)
-- - rust-analyzer (Rust)
-- - clangd (C/C++)
-- - jdtls (Java)
-- - omnisharp (C#)
-- - vue-language-server (Vue)
-- - html-lsp (HTML)
-- - css-lsp (CSS)
-- - json-lsp (JSON)
-- - lua-language-server (Lua)

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- Integration mellan Mason och LSP
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- Automatisk installation
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- Konfigurera Mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Konfigurera Mason LSP integration
    mason_lspconfig.setup({
      -- Lista över language servers att installera automatiskt
      ensure_installed = {
        "ts_ls",          -- TypeScript/JavaScript
        "pyright",        -- Python
        "rust_analyzer",  -- Rust
        "clangd",         -- C/C++
        "jdtls",          -- Java
        "omnisharp",      -- C#
        "html",           -- HTML
        "cssls",          -- CSS
        "jsonls",         -- JSON
        "lua_ls",         -- Lua
      },
      -- Automatisk installation av nya servers
      automatic_installation = true,
    })

    -- Installera ytterligare verktyg (formatters, linters)
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier",          -- TypeScript/JavaScript/HTML/CSS/JSON/Vue formatter
        "black",             -- Python formatter
        "rustfmt",           -- Rust formatter (installeras med rust-analyzer)
        "clang-format",      -- C/C++ formatter
        "google-java-format", -- Java formatter
        "stylua",            -- Lua formatter
        
        -- Linters
        "eslint_d",          -- JavaScript/TypeScript linter (snabbare än eslint)
        "flake8",            -- Python linter
        -- cppcheck för C/C++ (kan läggas till om önskas)
      },
    })
  end,
}
