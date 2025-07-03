-- NvimTree File Explorer Plugin
-- En kraftfull filutforskare som ersätter Neovims inbyggda netrw
-- 
-- Funktioner:
-- - Trädvy av filsystem med expanderbara mappar
-- - Git-integration med färgkodade filer
-- - Filoperationer: skapa, ta bort, kopiera, flytta filer/mappar
-- - Filtypsikoner för bättre visuell navigering
-- - Filtrering och sökning av filer
-- - Automatisk synkronisering med aktuell buffer
--
-- Tangentkommandon (inom NvimTree):
-- - Enter/o: Öppna fil eller mapp
-- - a: Skapa ny fil/mapp
-- - d: Ta bort fil/mapp  
-- - r: Döp om fil/mapp
-- - x: Klipp ut fil/mapp
-- - c: Kopiera fil/mapp
-- - p: Klistra in fil/mapp
-- - R: Uppdatera träd
-- - H: Växla visning av dolda filer
-- - q: Stäng NvimTree

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- För filtypsikoner
  config = function()
    local nvimtree = require("nvim-tree")
    
    -- Inaktivera netrw (Neovims inbyggda filhanterare) för att undvika konflikter
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
    
    -- Keymaps för nvim-tree
    local keymap = vim.keymap
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Växla filutforskare" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Växla filutforskare på aktuell fil" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Kollapsa filutforskare" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Uppdatera filutforskare" })
    keymap.set("n", "<leader>eg", "<cmd>NvimTreeOpen<CR>", { desc = "Open file explorer" })
  end,
}
