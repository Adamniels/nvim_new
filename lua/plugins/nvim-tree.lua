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
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeRefresh" },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- För filtypsikoner
    init = function()
        -- Open nvim-tree automatically when nvim is launched with a directory.
        -- This fires before the lazy cmd trigger so the tree appears on `nvim .`
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                if vim.fn.isdirectory(data.file) == 1 then
                    vim.cmd.cd(data.file)
                    require("nvim-tree.api").tree.open()
                end
            end,
        })
    end,
    config = function()
        local nvimtree = require("nvim-tree")
        local api = require("nvim-tree.api")
        local default_width = 35
        local focused_width = 55

        nvimtree.setup({
            view = {
                width = default_width,
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

        local function resize_tree_for_focus()
            local ok, is_visible = pcall(api.tree.is_visible)
            if not ok or not is_visible then
                return
            end

            local width = vim.bo.filetype == "NvimTree" and focused_width or default_width
            pcall(api.tree.resize, { absolute = width })
        end

        local tree_focus_group = vim.api.nvim_create_augroup("NvimTreeFocusWidth", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
            group = tree_focus_group,
            callback = resize_tree_for_focus,
        })

        -- Keymaps för nvim-tree
        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Växla filutforskare" })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Växla filutforskare på aktuell fil" })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Kollapsa filutforskare" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Uppdatera filutforskare" })
        -- keymap.set("n", "<f13>t", "<cmd>NvimTreeOpen<CR>", { desc = "Open file explorer" })
        keymap.set("n", "<f13>t", "<cmd>NvimTreeFindFile<CR>", { desc = "Växla filutforskare på aktuell fil" })
    end,
}
