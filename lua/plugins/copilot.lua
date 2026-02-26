return {
    -- GitHub Copilot (Lua implementation with better nvim-cmp integration)
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>", -- Alt+Enter to open panel
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-y>",        -- Accept whole suggestion
                        accept_word = "<S-Tab>", -- Accept word (Shift+Tab)
                        accept_line = "<Tab>",   -- Accept line (Tab)
                        next = "<C-n>",          -- Next suggestion
                        prev = "<C-p>",          -- Previous suggestion
                        dismiss = "<C-x>",       -- Dismiss suggestion
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },

    -- Copilot integration for nvim-cmp (shows Copilot suggestions in cmp menu)
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    -- GitHub Copilot Chat
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        event = "VeryLazy",
        opts = {
            debug = false,
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
                    prompt =
                    "/COPILOT_GENERATE Det finns ett problem med denna kod. Skriv om den så att den fungerar korrekt.",
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
            vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Copilot: Open Chat" })
            vim.keymap.set("v", "<leader>cc", "<cmd>CopilotChatVisual<cr>", { desc = "Copilot: Chat about marked code" })

            vim.keymap.set("n", "<leader>cq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    chat.ask(input, { selection = require("CopilotChat.select").buffer })
                end
            end, { desc = "Copilot: Quick chat" })
            vim.keymap.set("n", "<leader>cb", function()
                chat.ask("Förklara denna fil och vad den gör.", { selection = require("CopilotChat.select").buffer })
            end, { desc = "Copilot: Chat about file" })
        end,
    },
}
