-- LSP Configuration
-- Language Server Protocol setup för intelligent kodredigering
--
-- Funktioner som LSP ger dig:
-- - Intelligent autocomplettering baserat på projektkontext
-- - Feldetektering i realtid (röda understrykningar)
-- - Go to definition (gd) - hoppa till funktionsdefinitioner
-- - Hover documentation (K) - visa dokumentation för funktioner
-- - Rename symbols (F2) - döp om variabler säkert i hela projektet
-- - Code actions (Ctrl+.) - föreslår fixes och refactoring
-- - Formatering av kod enligt språkstandarder
-- - Diagnostics - varningar och fel från language servers
--
-- Språkservrar som kommer att installeras:
-- - TypeScript/JavaScript: typescript-language-server
-- - Python: pyright (Microsoft's Python language server)
-- - Rust: rust-analyzer
-- - C/C++: clangd
-- - Java: jdtls (Eclipse JDT Language Server)
-- - C#: omnisharp
-- - HTML/CSS: html-lsp, css-lsp
-- - JSON: json-lsp
-- - Lua: lua-language-server

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source för nvim-cmp
    { "antosha417/nvim-lsp-file-operations", config = true }, -- File operations i LSP
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Tangentbindningar för LSP
    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- LSP Keymaps (fungerar bara när LSP är aktivt)
      opts.desc = "Visa LSP referenser"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Gå till deklaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Visa LSP definitioner"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Visa LSP implementationer"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Visa LSP typ definitioner"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "Visa tillgängliga code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Visa buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Visa rad diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Gå till föregående diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Gå till nästa diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Visa dokumentation för det under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Starta om LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    -- Capabilities för autocomplettering
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Konfigurera diagnostics (nya metoden för Neovim 0.11+)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = {
        prefix = "●", -- Används för virtual text
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- TypeScript/JavaScript
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Python
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Rust
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    })

    -- C/C++
    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Java
    lspconfig["jdtls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- C#
    lspconfig["omnisharp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- HTML
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- CSS
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- JSON
    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Lua (för Neovim konfiguration)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- Känner igen vim global
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
