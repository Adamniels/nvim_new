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
				desc = "Accept Copilot-suggestion",
			})

			-- Navigera mellan förslag
			vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)", { desc = "Next Copilot-suggestion" })
			vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)", { desc = "Previous Copilot-suggestion" })

			-- Avvisa förslag
			vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)", { desc = "Decline Copilot-suggestion" })

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
					description = "Copilot: Förklara kod",
				},
				Review = {
					prompt = "/COPILOT_REVIEW Granska denna kod och ge förbättringsförslag.",
					mapping = "<leader>cr",
					description = "Copilot: Granska kod",
				},
				Fix = {
					prompt = "/COPILOT_GENERATE Det finns ett problem med denna kod. Skriv om den så att den fungerar korrekt.",
					mapping = "<leader>cf",
					description = "Copilot: Fixa kod",
				},
				Optimize = {
					prompt = "/COPILOT_GENERATE Optimera denna kod för bättre prestanda och läsbarhet.",
					mapping = "<leader>co",
					description = "Copilot: Optimera kod",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE Skriv dokumentation för denna kod.",
					mapping = "<leader>cd",
					description = "Copilot: Generera dokumentation",
				},
				Tests = {
					prompt = "/COPILOT_GENERATE Skriv tester för denna kod.",
					mapping = "<leader>ct",
					description = "Copilot: Generera tester",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)

			-- Keymaps för Copilot Chat
			vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Copilot: Open Copilot Chat" })
			vim.keymap.set(
				"v",
				"<leader>cc",
				"<cmd>CopilotChatVisual<cr>",
				{ desc = "Copilot: Chat about marked code" }
			)
			vim.keymap.set("n", "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end, { desc = "Copilot: Quick Copilot-chat" })

			-- Copilot Chat med hela filen
			vim.keymap.set("n", "<leader>cb", function()
				chat.ask("Förklara denna fil och vad den gör.", { selection = require("CopilotChat.select").buffer })
			end, { desc = "Copilot: Chat about whole file" })
		end,
	},
}
