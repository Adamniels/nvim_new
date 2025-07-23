-- för att få ner NetCoreDbg som behövs för Csharp kör cmd: yay -S netcoredbg i arch linux

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "debugpy" },
				automatic_installation = true,
				handlers = {},
			})

			-- Adapter för C# (NetCoreDbg)
			dap.adapters.coreclr = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch - NetCoreDbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net9.0/", "file")
					end,
				},
			}

			-- UI auto-open och keybinds
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Nyckelbindningar
			local map = vim.keymap.set
			map("n", "<F5>", function()
				dap.continue()
			end, { desc = "Start/Continue debug" })
			map("n", "<F10>", function()
				dap.step_over()
			end, { desc = "Step Over" })
			map("n", "<F11>", function()
				dap.step_into()
			end, { desc = "Step Into" })
			map("n", "<F12>", function()
				dap.step_out()
			end, { desc = "Step Out" })
			map("n", "<leader>b", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })
			map("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			map("n", "<leader>du", function()
				dapui.toggle()
			end, { desc = "Toggle DAP UI" })
		end,
	},
}
