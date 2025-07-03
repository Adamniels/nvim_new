return {
	"easymotion/vim-easymotion",
	event = "VeryLazy",
	init = function()
		vim.g.EasyMotion_do_mapping = 0 -- stäng av default-mappings

		local keymap = vim.keymap.set

		-- hoppa till nästa ord (framåt, som 'w')
		keymap("n", "<leader><leader>w", "<Plug>(easymotion-w)", { desc = "Hoppa till ord framåt (EasyMotion)" })

		-- hoppa till föregående ord (bakåt, som 'b')
		keymap("n", "<leader><leader>b", "<Plug>(easymotion-b)", { desc = "Hoppa till ord bakåt (EasyMotion)" })

		-- hoppa till nästa rad
		keymap("n", "<leader><leader>j", "<Plug>(easymotion-j)", { desc = "Hoppa ner (EasyMotion)" })

		-- hoppa till föregående rad
		keymap("n", "<leader><leader>k", "<Plug>(easymotion-k)", { desc = "Hoppa upp (EasyMotion)" })

		-- visa hopp till ALLA ord i hela skärmen (search-mode / "skörd")
		keymap("n", "<leader><leader>/", "<Plug>(easymotion-sn)", { desc = "Hoppa till sökresultat (skörda ord)" })
	end,
}
