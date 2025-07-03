-- Treesitter Syntax Highlighting Plugin
-- Avancerad syntax highlighting baserat på språkens AST (Abstract Syntax Tree)
--
-- Funktioner:
-- - Mycket mer exakt syntax highlighting än traditionella regex-baserade lösningar
-- - Intelligent indentation baserat på språkstruktur
-- - Incremental selection för att välja kod-block logiskt
-- - Stöd för många programmeringsspråk och markup languages
-- - Plugin-ekosystem för kod-manipulation baserat på syntax
-- - Folding support baserat på språkstruktur
-- - Kontext-medveten highlighting
--
-- Språk som installeras automatiskt:
-- - Webbutveckling: JavaScript, TypeScript, HTML, CSS
-- - Data: JSON, YAML
-- - Dokumentation: Markdown
-- - System: Bash, Dockerfile
-- - Konfiguration: Lua, Vim script
-- - Programmering: Python
--
-- Tangentkommandon för incremental selection:
-- - Ctrl+Space: Börja selection eller utöka selection
-- - Backspace: Minska selection

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" }, -- Ladda när fil öppnas
  build = ":TSUpdate", -- Uppdatera parsers vid installation
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = {
        -- Webbutveckling
        "javascript",
        "typescript", 
        "tsx",
        "html",
        "css",
        "vue",
        "json",
        
        -- System programming
        "c",
        "rust",
        "java",
        
        -- .NET
        "c_sharp",
        
        -- Scripting
        "python",
        "lua",
        "bash",
        
        -- Markup och config
        "markdown",
        "markdown_inline",
        "yaml",
        "dockerfile",
        "gitignore",
        "vim",
        
        -- Övrigt
        "regex",
        "sql",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
