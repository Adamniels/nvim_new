-- för att få ner NetCoreDbg som behövs för Csharp kör cmd: yay -S netcoredbg i arch linux

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            --------------------------------------------------------------------
            -- NEW: inline-variabler (virtual text)
            --------------------------------------------------------------------
            require("nvim-dap-virtual-text").setup({
                -- visa värden även för variabler som inte ändrats
                highlight_changed_variables = true,
                show_stop_reason = true,
                commented = false, -- om true -> kommentars-prefix framför värden
            })

            --------------------------------------------------------------------
            -- DAP UI + Mason
            --------------------------------------------------------------------
            dapui.setup()

            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb", "debugpy" },
                automatic_installation = true,
                handlers = {},
            })

            --------------------------------------------------------------------
            -- C# (NetCoreDbg)
            --------------------------------------------------------------------
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
                        return vim.fn.input(
                            "Path to dll: ",
                            vim.fn.getcwd() .. "/bin/Debug/net9.0/",
                            "file"
                        )
                    end,
                },
            }

            --------------------------------------------------------------------
            -- Python (debugpy)
            --------------------------------------------------------------------
            -- Adapter för Python (debugpy)
            dap.adapters.debugpy = {
                type = "executable",
                command = "python3", -- eller "python" beroende på system
                args = { "-m", "debugpy.adapter" },
            }

            dap.configurations.python = {
                {
                    type = "debugpy",
                    request = "launch",
                    name = "Launch current file",
                    program = "${file}", -- kör aktuell buffert
                    console = "integratedTerminal",
                },
            }

            --------------------------------------------------------------------
            -- UI auto-open och stängning
            --------------------------------------------------------------------
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated["dapui_config"] = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited["dapui_config"] = function()
            --     dapui.close()
            -- end

            --------------------------------------------------------------------
            -- Nyckelbindningar (EXISTERANDE)
            --------------------------------------------------------------------
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
            map("n", "<leader>gb", function()
                dap.toggle_breakpoint()
            end, { desc = "Toggle Breakpoint" })
            map("n", "<leader>gB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end)
            map("n", "<leader>gu", function()
                dapui.toggle()
            end, { desc = "Toggle DAP UI" })

            --------------------------------------------------------------------
            -- NEW: snyggare symboler för breakpoints & current line
            --------------------------------------------------------------------
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg" })
            vim.fn.sign_define("DapStopped", { text = "➜", texthl = "WarningMsg" })

            -- NEW: highlight på raden där exekveringen står
            vim.cmd([[
              hi DapStopped guibg=#3b4252 guifg=#e5e9f0
            ]])

            --------------------------------------------------------------------
            -- NEW: hover-inspect på variabler (som i VSCode)
            --------------------------------------------------------------------
            map({ "n", "v" }, "<leader>dh", function()
                require("dap.ui.widgets").hover()
            end, { desc = "DAP Hover" })
        end,
    },
}
