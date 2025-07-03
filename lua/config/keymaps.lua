-- Keymaps
-- Tangentbordsmappningar

local keymap = vim.keymap

-- Leader key
vim.g.mapleader = " "

-- Normal mode mappings
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Rensa sökmarkering" })

-- Fönsterhantering
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Dela fönster vertikalt" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Dela fönster horisontellt" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Gör fönster lika stora" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Stäng aktuellt fönster" })

-- Flik-hantering
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Öppna ny flik" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Stäng aktuell flik" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Gå till nästa flik" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Gå till föregående flik" })

-- Buffer-hantering
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Ta bort buffer" })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Nästa buffer" })
keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Föregående buffer" })

-- Flytta text upp och ner
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Flytta markerad text ner" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Flytta markerad text upp" })

-- Smart: - (upp) och _ (ner) - samma tangent med/utan Shift
keymap.set("n", "_", ":m .-2<CR>==", { desc = "Flytta rad upp" })
keymap.set("n", "-", ":m .+1<CR>==", { desc = "Flytta rad ner" })
keymap.set("v", "_", ":m '<-2<CR>gv=gv", { desc = "Flytta markering upp" })
keymap.set("v", "-", ":m '>+1<CR>gv=gv", { desc = "Flytta markering ner" })

-- Behåll cursor i mitten vid scroll, scroll med ctrl-d och ctrl-u
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Behåll markering vid indentering
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Bättre navigation i insert mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
