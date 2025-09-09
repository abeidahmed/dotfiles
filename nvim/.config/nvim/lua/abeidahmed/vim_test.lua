return {
	"vim-test/vim-test",
	dependencies = {
		"tpope/vim-dispatch",
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>rt", ":TestNearest<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>rf", ":TestFile<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ra", ":TestSuite<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>rl", ":TestLast<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>rv", ":TestVisit<CR>", { noremap = true, silent = true })

		vim.cmd([[
      let test#strategy = "dispatch"
    ]])
	end,
}
