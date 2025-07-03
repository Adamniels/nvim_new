-- Which-Key Plugin
-- Visar tillgängliga keymaps i en popup när du trycker på leader-tangenten eller andra prefix
-- Gör det lätt att komma ihåg och upptäcka tangentbordsmappningar
--
-- Which-key upptäcker automatiskt alla keymaps som har desc (beskrivning)
-- och visar dem i kategorier. Mycket smartare än att manuellt definiera allt!

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup({
			preset = "modern", -- Använd moderna ikoner och layout
			delay = 300, -- Vänta 300ms innan popup visas
			icons = {
				mappings = true, -- Visa ikoner för mappings
			},
		})
	end,
}
