-- Telescope Fuzzy Finder Plugin
-- En kraftfull och utbyggbar fuzzy finder för Neovim
--
-- Funktioner:
-- - Snabb filsökning med fuzzy matching
-- - Live grep för att söka text i alla filer
-- - Bufferthantering och navigation
-- - Git-integration (commits, branches, status)
-- - Kommandshistorik och hjälptext
-- - Anpassningsbara selectors och previews
-- - Stöd för extensions och custom pickers
--
-- Söktips:
-- - Använd mellanslag för att separera söktermer
-- - '!' framför ord exkluderar det från sökningen
-- - '^' i början matchar början av filnamn
-- - '$' i slutet matchar slutet av filnamn
-- - Använd path/to/ för att söka i specifik mapp
--
-- Tangentkommandon (inom Telescope):
-- - Ctrl+j/k: Navigera upp/ner i lista
-- - Ctrl+q: Skicka resultat till quickfix list
-- Ctrl+x: Öppna fil i horisontell split
-- - Enter: Öppna fil i aktuellt fönster
-- - Ctrl+v: Öppna fil i vertikal split
-- - Ctrl+t: Öppna fil i ny tab
-- - Ctrl+u/d: Scrolla preview upp/ner

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Lua-funktioner som Telescope behöver
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Snabbare fuzzy finding
		"nvim-tree/nvim-web-devicons", -- Filtypsikoner
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- Keymaps för telescope
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Hitta filer i cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "find in current file" })
		-- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Hitta senaste filer" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Hitta sträng i cwd" })
		-- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Hitta sträng under cursor i cwd" })
	end,
}
