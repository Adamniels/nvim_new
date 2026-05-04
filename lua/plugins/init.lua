-- Plugin Konfigurationer
-- Automatisk import av alla plugin-filer inklusive undermappar

-- Grundläggande dependencies som många andra plugins beror på.
-- Alla andra plugin-filer i lua/plugins/ importeras automatiskt
-- av lazy.lua via { import = "plugins" } -- inga extra imports behövs här.
return {
	"nvim-lua/plenary.nvim",        -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
}
