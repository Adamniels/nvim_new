-- Code Formatting Plugin
-- Automatisk formatering av kod baserat på språkstandarder
--
-- Funktioner:
-- - Format on save - automatisk formatering när du sparar filer
-- - Stöd för många språk via externa formatters
-- - Integration med LSP för formatering
-- - Anpassningsbara regler per filtyp
-- - Snabb manuell formatering med tangentkommando
--
-- Formatters som används:
-- - Prettier: JavaScript, TypeScript, HTML, CSS, JSON, Vue
-- - Black: Python kod-formatering enligt PEP 8
-- - rustfmt: Rust kod-formatering
-- - clang-format: C/C++ kod-formatering
-- - LSP: Använder language server för andra språk
--
-- Tangentkommandon:
-- - <leader>mp: Formatera aktuell buffer manuellt
-- - Automatisk formatering sker när du sparar filer (:w)

return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- Ladda när fil öppnas
  config = function()
    local conform = require("conform")

    conform.setup({
      -- Konfigurera formatters per filtyp
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        java = { "google-java-format" },
        lua = { "stylua" },
      },

      -- Anpassa formatter-inställningar
      formatters = {
        black = {
          prepend_args = { "--line-length", "79" }, -- Matcha flake8's radlängd
        },
      },
      
      -- Format on save konfiguration
      format_on_save = {
        lsp_fallback = true, -- Använd LSP om ingen formatter finns
        async = false,       -- Synkron formatering för säkerhet
        timeout_ms = 3000,   -- Ökat timeout för formatering (3 sekunder)
      },
    })

    -- Tangentbindning för manuell formatering
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000, -- Ökat timeout för manuell formatering
      })
    end, { desc = "Formatera fil eller selection" })

    -- Kommando för att kontrollera tillgängliga formatters
    vim.keymap.set("n", "<leader>mi", function()
      local filetype = vim.bo.filetype
      local formatters = conform.list_formatters(0)
      if #formatters == 0 then
        vim.notify("Inga formatters tillgängliga för filtyp: " .. filetype, vim.log.levels.WARN)
      else
        local formatter_names = {}
        for _, formatter in ipairs(formatters) do
          table.insert(formatter_names, formatter.name .. " (" .. (formatter.available and "tillgänglig" or "ej tillgänglig") .. ")")
        end
        vim.notify("Formatters för " .. filetype .. ":\n" .. table.concat(formatter_names, "\n"), vim.log.levels.INFO)
      end
    end, { desc = "Visa tillgängliga formatters" })
  end,
}
