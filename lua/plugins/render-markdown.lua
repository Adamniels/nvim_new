-- Render Markdown Plugin
-- Ger en snyggare visning av markdown-filer direkt i Neovim
--
-- Funktioner:
-- - Renderar headers med bakgrundsfärger och ikoner
-- - Visar checkboxar och listor snyggt
-- - Renderar tabeller med bättre formatering
-- - Syntax highlighting för kodblock
-- - Döljer markdown-syntax för renare visning

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- För ikoner (valfritt men rekommenderat)
  },
  ft = { "markdown" }, -- Ladda endast för markdown-filer
  config = function()
    require("render-markdown").setup({
      -- Aktivera rendering
      enabled = true,

      -- Rendera i dessa filtyper
      file_types = { "markdown" },

      -- Headers med olika stilar
      heading = {
        enabled = true,
        sign = true, -- Visa tecken i sign column
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },

      -- Kodblock
      code = {
        enabled = true,
        sign = true,
        style = "full", -- full, normal, eller language
        width = "full",
        border = "thin",
      },

      -- Horisontella linjer
      dash = {
        enabled = true,
        width = "full",
      },

      -- Bullet points
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },

      -- Checkboxar
      checkbox = {
        enabled = true,
        unchecked = {
          icon = " ",
        },
        checked = {
          icon = " ",
        },
      },

      -- Citat/blockquotes
      quote = {
        enabled = true,
        icon = "▎",
      },

      -- Tabeller
      pipe_table = {
        enabled = true,
        style = "full",
      },

      -- Länkar
      link = {
        enabled = true,
        image = "󰥶 ",
        hyperlink = "󰌹 ",
      },
    })

    -- Keymap för att toggla rendering
    vim.keymap.set("n", "<leader>mr", function()
      require("render-markdown").toggle()
    end, { desc = "Toggle Markdown Rendering" })
  end,
}
