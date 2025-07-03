-- Code Linting Plugin
-- Kod-kvalitetskontroll och stilkontroll utöver LSP
--
-- Funktioner:
-- - Linting i realtid medan du skriver
-- - Stöd för många linters per språk
-- - Integration med diagnostics systemet
-- - Anpassningsbara regler och konfigurationer
-- - Automatisk körning vid fil-ändringar
--
-- Linters som används:
-- - ESLint: JavaScript/TypeScript kod-kvalitet och stil
-- - Flake8: Python kod-kvalitet och PEP 8 compliance
-- - Clippy: Rust linting och suggestions (via rust-analyzer)
-- - cppcheck: C/C++ statisk analys
--
-- Linting körs automatiskt:
-- - När du öppnar en fil
-- - När du gör ändringar i en fil
-- - När du sparar en fil
--
-- Linting-meddelanden visas:
-- - Som understrykningar i koden
-- - I diagnostics popup (samma som LSP fel)
-- - I quickfix list för navigation

return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- Ladda när fil öppnas
  config = function()
    local lint = require("lint")

    -- Konfigurera linters per filtyp
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "flake8" },
      -- Rust använder clippy via rust-analyzer LSP
      -- C/C++ använder clang-tidy via clangd LSP
    }

    -- Anpassa linter-inställningar
    lint.linters.flake8.args = {
      "--max-line-length=79", -- Matcha black's radlängd
      "--extend-ignore=E203,W503", -- Ignorera konflikter med black
    }

    -- Skapa autocommand group för linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Kör linting automatiskt
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Tangentbindning för manuell linting
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigga linting för aktuell fil" })
  end,
}
