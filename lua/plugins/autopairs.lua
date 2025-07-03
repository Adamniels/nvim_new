-- Auto Pairs Plugin
-- Automatisk hantering av matchande parenteser, klamrar och citattecken
--
-- Funktioner:
-- - Automatisk stängning av (, [, {, ", '
-- - Intelligent hantering baserat på filtyp och kontext
-- - Treesitter integration för bättre syntax awareness
-- - Fast wrap funktionalitet för att snabbt omsluta text
-- - Smart deletion - tar bort både öppnande och stängande tecken
-- - Undviker autopairs i kommentarer och strängar (beroende på kontext)
-- - Integration med completion plugins
--
-- Beteende:
-- - Skriv '(' så läggs ')' till automatiskt med cursor i mitten
-- - Backspace på '()' tar bort båda tecknen
-- - Alt+e aktiverar fast wrap mode för att snabbt omsluta text
-- - Fungerar intelligent med olika programmeringsspråk
--
-- Fast wrap exempel:
-- - Markera text, tryck Alt+e, skriv ( för att omsluta med parenteser

return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" }, -- Ladda endast i insert mode
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })

    -- Integrera med nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
