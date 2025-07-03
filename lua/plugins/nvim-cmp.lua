-- NvimCmp Auto Completion Plugin
-- Modernt completion framework för Neovim med stöd för många källor
--
-- Funktioner:
-- - Intelligent autocomplettering baserat på kontext
-- - Stöd för LSP (Language Server Protocol) förslag
-- - Snippet expansion och navigation
-- - Buffer-baserade förslag från öppna filer
-- - Filsökvägscomplettering
-- - Anpassningsbara completion sources
-- - Fuzzy matching för förslag
-- - Rich documentation previews
--
-- Källor som används:
-- - luasnip: Code snippets från friendly-snippets
-- - buffer: Text från alla öppna buffrar
-- - path: Filsökvägar och mappar
--
-- Tangentkommandon (inom completion popup):
-- - Ctrl+j/k: Navigera ner/upp i completion lista
-- - Ctrl+b/f: Scrolla dokumentation ner/upp
-- - Ctrl+Space: Trigga completion manuellt
-- - Enter: Bekräfta valt förslag
-- - Ctrl+e: Avbryt completion
-- - Tab/Shift+Tab: Navigera i snippets

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Ladda endast när vi går in i insert mode
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP completion source (VIKTIGT för intelligent completion)
    "hrsh7th/cmp-buffer", -- Completion från text i öppna buffrar
    "hrsh7th/cmp-path", -- Completion för filsökvägar
    {
      "L3MON4D3/LuaSnip", -- Snippet engine
      version = "v2.*",
      build = "make install_jsregexp", -- Installera regex stöd
    },
    "saadparwaiz1/cmp_luasnip", -- LuaSnip source för nvim-cmp
    "rafamadriz/friendly-snippets", -- Samling av användbara snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Ladda vscode-stil snippets från friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP completion (HÖGST PRIORITET)
        { name = "luasnip" },  -- Snippets
        { name = "buffer" },   -- Text från buffrar
        { name = "path" },     -- Filsökvägar
      }),
    })
  end,
}
