return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        -- setup with custom keyword "REDOVISA"
        todo_comments.setup({
            keywords = {
                TODO = { icon = " ", color = "info" },
                FIXME = { icon = " ", color = "error" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning" },
                PERF = { icon = " ", color = "hint" },
                NOTE = { icon = " ", color = "hint" },
                -- Lägg till din egen nyckel här
                REDOVISA = { icon = " ", color = "error", alt = { "REPORT" } },
                PLAN = { icon = " ", color = "info" },
            },
        })
    end,
}
