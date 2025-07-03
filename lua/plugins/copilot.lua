return {
	-- GitHub Copilot AI-kodassistent
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			-- Aktivera Copilot för alla filtyper
			vim.g.copilot_filetypes = {
				["*"] = true,
			}

			-- Anpassade keybindings för Copilot
			vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
				desc = "Acceptera Copilot-förslag",
			})

			-- Navigera mellan förslag
			vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { desc = "Nästa Copilot-förslag" })
			vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { desc = "Föregående Copilot-förslag" })

			-- Avvisa förslag
			vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)", { desc = "Avvisa Copilot-förslag" })

			-- Aktivera Tab för att acceptera förslag (default Copilot-beteende)
			-- Tab kommer att acceptera Copilot-förslag när de visas
		end,
	},

	-- GitHub Copilot Chat (AI-chat i Neovim)
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "github/copilot.vim" }, -- or github/copilot.lua
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		event = "VeryLazy",
		opts = {
			debug = false, -- Enable debugging
			-- Anpassade prompts för vanliga uppgifter
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN Förklara hur denna kod fungerar.",
					mapping = "<leader>ce",
					description = "Förklara kod",
				},
				Review = {
					prompt = "/COPILOT_REVIEW Granska denna kod och ge förbättringsförslag.",
					mapping = "<leader>cr",
					description = "Granska kod",
				},
				Fix = {
					prompt = "/COPILOT_GENERATE Det finns ett problem med denna kod. Skriv om den så att den fungerar korrekt.",
					mapping = "<leader>cf",
					description = "Fixa kod",
				},
				Optimize = {
					prompt = "/COPILOT_GENERATE Optimera denna kod för bättre prestanda och läsbarhet.",
					mapping = "<leader>co",
					description = "Optimera kod",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE Skriv dokumentation för denna kod.",
					mapping = "<leader>cd",
					description = "Generera dokumentation",
				},
				Tests = {
					prompt = "/COPILOT_GENERATE Skriv tester för denna kod.",
					mapping = "<leader>ct",
					description = "Generera tester",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)

			-- Keymaps för Copilot Chat
			vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Öppna Copilot Chat" })
			vim.keymap.set("v", "<leader>cc", "<cmd>CopilotChatVisual<cr>", { desc = "Chat om vald kod" })
			vim.keymap.set("n", "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end, { desc = "Snabb Copilot-fråga" })

			-- Copilot Chat med hela filen
			vim.keymap.set("n", "<leader>cb", function()
				chat.ask("Förklara denna fil och vad den gör.", { selection = require("CopilotChat.select").buffer })
			end, { desc = "Chat om hela filen" })
		end,
	},
}
