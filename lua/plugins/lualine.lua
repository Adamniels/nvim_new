-- Lualine Status Line Plugin
-- En snabb och lättanpassad statusrad för Neovim
--
-- Funktioner:
-- - Visar aktuell mode (normal, insert, visual, etc.)
-- - Filnamn och modifieringsstatus
-- - Git branch och ändringar (lägg till/ändra/ta bort)
-- - Diagnostik från LSP (errors, warnings, info, hints)
-- - Filtyp och encoding information
-- - Radnummer och kolumnposition
-- - Procent av fil och total rader
-- - Anpassningsbara teman och komponenter
--
-- Statusrad layout (vänster till höger):
-- - Mode indicator
-- - Git branch
-- - Filnamn
-- - Diagnostik
-- - ... (mellanrum)
-- - Filtyp
-- - File encoding
-- - Position i fil
-- - Procent genom fil

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- För ikoner i statusraden
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            options = {
                theme = "onedark",
            },
        })
    end,
}
