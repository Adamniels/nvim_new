return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                inline = {
                    adapter = "openai" -- "anthropic" or "openai"
                },
            },
            adapters = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = {
                            api_key = "ANTHROPIC_API_KEY", -- Set env variable: export ANTHROPIC_API_KEY=your_key
                        },
                        schema = {
                            model = {
                                default = "claude-sonnet-4.5-20250514", -- Claude Sonnet 4.5
                            },
                        },
                    })
                end,
                openai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            api_key = "OPENAI_API_KEY", -- Set env variable: export OPENAI_API_KEY=your_key
                        },
                        schema = {
                            model = {
                                default = "gpt-5.3-turbo", -- or whatever GPT 5.3 model name is
                            },
                        },
                    })
                end,
            },
            display = {
                action_palette = {
                    width = 95,
                    height = 10,
                },
            },
            prompt_library = {
                ["Optimize"] = {
                    strategy = "inline",
                    description = "Optimize selected code",
                    prompts = {
                        {
                            role = "system",
                            content =
                            "You are an expert at code optimization. Optimize code for performance and readability.",
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Optimize the following code:\n\n" .. context.selection
                            end,
                            opts = {
                                contains_code = true,
                            },
                        },
                    },
                },
                ["Fix"] = {
                    strategy = "inline",
                    description = "Fix problems in the code",
                    prompts = {
                        {
                            role = "system",
                            content = "You are an expert at identifying and fixing bugs in code.",
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Identify and fix problems in this code:\n\n" .. context.selection
                            end,
                            opts = {
                                contains_code = true,
                            },
                        },
                    },
                },
                ["Comment"] = {
                    strategy = "inline",
                    description = "Add comments to the code",
                    prompts = {
                        {
                            role = "system",
                            content = "Add clear and concise comments to code.",
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Add comments to this code:\n\n" .. context.selection
                            end,
                            opts = {
                                contains_code = true,
                            },
                        },
                    },
                },
                ["Documentation"] = {
                    strategy = "inline",
                    description = "Generate documentation",
                    prompts = {
                        {
                            role = "system",
                            content = "Write clear and comprehensive documentation for code.",
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Write documentation for this code:\n\n" .. context.selection
                            end,
                            opts = {
                                contains_code = true,
                            },
                        },
                    },
                },
                ["Refactor"] = {
                    strategy = "inline",
                    description = "Refactor code",
                    prompts = {
                        {
                            role = "system",
                            content = "Refactor code for better structure and readability.",
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Refactor this code:\n\n" .. context.selection
                            end,
                            opts = {
                                contains_code = true,
                            },
                        },
                    },
                },
            },
        })

        -- Keymaps
        local keymap = vim.keymap.set

        -- Actions menu
        keymap("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion: Actions" })
        keymap("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion: Actions" })

        -- Inline prompt
        keymap("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline Prompt" })
        keymap("v", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline Prompt" })
        keymap("n", "<F13>i", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline Prompt (F13+i)" })
        keymap("v", "<F13>i", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline Prompt (F13+i)" })

        -- Quick inline actions with visual selection
        keymap("v", "<leader>af", ":CodeCompanion Fix<CR>", { desc = "CodeCompanion: Fix" })
        keymap("v", "<leader>ao", ":CodeCompanion Optimize<CR>", { desc = "CodeCompanion: Optimize" })
        keymap("v", "<leader>ad", ":CodeCompanion Documentation<CR>", { desc = "CodeCompanion: Documentation" })
        keymap("v", "<leader>ar", ":CodeCompanion Refactor<CR>", { desc = "CodeCompanion: Refactor" })
        keymap("v", "<leader>ak", ":CodeCompanion Comment<CR>", { desc = "CodeCompanion: Comment" })


        -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd([[cab cc CodeCompanion]])
    end,
}
