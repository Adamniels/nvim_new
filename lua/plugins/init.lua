-- Plugin Konfigurationer
-- Automatisk import av alla plugin-filer inklusive undermappar

return {
	-- Grundläggande dependencies
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	-- Importera LSP-plugins från lsp/ undermappen
	{ import = "plugins.lsp" },
	-- Importera enskilda plugin-filer
	{ import = "plugins.copilot" },
	{ import = "plugins.noice" },
}
