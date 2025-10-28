-- Noice.nvim - Better UI for messages, cmdline and popupmenu
-- Replaces the UI for messages, cmdline and the popupmenu with a modern interface
-- Features:
-- - Beautiful cmdline with syntax highlighting
-- - Better search UI with highlighting
-- - Modern popupmenu with icons
-- - LSP progress notifications
-- - Command history with fuzzy search
-- - Customizable notification system

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- LSP configuration
        lsp = {
            -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            -- Show LSP progress notifications
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            -- Hover documentation styling
            hover = {
                enabled = true,
                silent = false, -- set to true to not show a message if hover is not available
            },
            -- Signature help styling
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50,  -- Debounce lsp signature help request by 50ms
                },
                view = nil,         -- when nil, use defaults from documentation
                opts = {},          -- merged with defaults from documentation
            },
        },
        -- Presets for easier configuration
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },

        -- Messages configuration
        messages = {
            enabled = true,              -- enables the Noice messages UI
            view = "notify",             -- default view for messages
            view_error = "notify",       -- view for errors
            view_warn = "notify",        -- view for warnings
            view_history = "messages",   -- view for :messages
            view_search = "virtualtext", -- view for search count messages
        },

        -- Notification configuration
        notify = {
            enabled = true,
            view = "notify",
        },

        -- Command line configuration
        cmdline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline
            opts = {},              -- global options for the cmdline
            format = {
                -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                -- view: (default is cmdline view)
                -- opts: any options passed to the view
                -- icon_hl_group: optional hl_group for the icon
                -- title: set to anything or empty string to hide
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
            },
        },

        -- Popupmenu configuration
        popupmenu = {
            enabled = true,  -- enables the Noice popupmenu UI
            backend = "nui", -- backend to use to show regular cmdline completions
            kind_icons = {}, -- set to false to disable icons
        },

        -- Routes configuration for message handling
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "search hit BOTTOM",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "search hit TOP",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "emsg",
                    find = "E486",
                },
                opts = { skip = true },
            },
        },

        -- View configuration
        views = {
            cmdline_popup = {
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 8,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
    },

    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "NONE",
                stages = "fade_in_slide_out",
                render = "compact",
            }
        },
    },
}
