-- Catppuccin Colorscheme Plugin
-- Ett modernt och vackert färgtema för Neovim med flera varianter
-- Tillgängliga varianter: latte (ljus), frappe, macchiato, mocha (mörk)
--
-- Funktioner:
-- - Stöd för många plugins och filetypes
-- - Konsistent färgschema genom hela editorn
-- - Anpassningsbara färger och stilar
-- - Bra kontrast och läsbarhet

return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "dark"
        })
        require("onedark").load()
    end
}
-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000, -- Ladda först för att undvika färgproblem
--     config = function()
--         -- Konfigurera catppuccin innan vi aktiverar det
--         require("catppuccin").setup({
--             flavour = "mocha", -- latte, frappe, macchiato, mocha
--             background = {     -- :h background
--                 light = "latte",
--                 dark = "mocha",
--             },
--             transparent_background = true,
--             show_end_of_buffer = false,
--             term_colors = false,
--             dim_inactive = {
--                 enabled = false,
--                 shade = "dark",
--                 percentage = 0.15,
--             },
--             no_italic = false,
--             no_bold = false,
--             no_underline = false,
--             styles = {
--                 comments = { "italic" },
--                 conditionals = { "italic" },
--                 loops = {},
--                 functions = {},
--                 keywords = {},
--                 strings = {},
--                 variables = {},
--                 numbers = {},
--                 booleans = {},
--                 properties = {},
--                 types = {},
--                 operators = {},
--             },
--         })
--
--         -- Aktivera färgtemat
--         vim.cmd([[colorscheme catppuccin]])
--     end,
-- }
