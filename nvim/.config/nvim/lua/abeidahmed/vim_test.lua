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
      function! VimTestProjectRoot()
        let l:markers = {
          \ 'ruby': 'Gemfile.lock',
          \ 'go': 'go.mod',
          \ 'typescript': 'package.json',
          \ 'typescriptreact': 'package.json',
          \ 'javascript': 'package.json',
          \ 'javascriptreact': 'package.json',
          \ }
        let l:marker = get(l:markers, &filetype, '')
        if empty(l:marker)
          return getcwd()
        endif
        let l:found = findfile(l:marker, '.;')
        return empty(l:found) ? getcwd() : fnamemodify(l:found, ':p:h')
      endfunction

      let test#strategy = "dispatch"
      let test#project_root = function('VimTestProjectRoot')
    ]])
	end,
}
