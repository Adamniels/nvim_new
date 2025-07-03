-- Comment Plugin
-- Intelligent kommentering av kod som förstår olika programmeringsspråks kommentarsyntax
--
-- Funktioner:
-- - Automatisk detection av rätt kommentarsyntax baserat på filtyp
-- - Stöd för både rad- och blockkommentarer
-- - Toggle funktionalitet - kommenterar/avkommenterar automatiskt
-- - Behåller indentation när kommentarer läggs till/tas bort
-- - Stöd för embedded languages (t.ex. JavaScript i HTML)
-- - Treesitter integration för bättre språkförståelse
-- - Respekterar kommentarens position i koden
--
-- Språkexempel:
-- - JavaScript/TypeScript: // för rader, /* */ för block
-- - Python: # för rader
-- - HTML: <!-- --> för block  
-- - CSS: /* */ för block
-- - Lua: -- för rader, --[[ ]] för block
-- - Vim: " för rader
--
-- Tangentkommandon:
-- - gcc: Toggle kommentar på aktuell rad
-- - gbc: Toggle blockkommentar på aktuell rad
-- - gc + motion: Kommentera motion (t.ex. gcap för paragraf)
-- - gb + motion: Blockkommentera motion
-- - gc i visual mode: Kommentera markerad text

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Ladda när fil öppnas
  config = function()
    local comment = require("Comment")

    comment.setup({
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
    })
  end,
}
