local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap('n', '<leader>rt', ':TestNearest<CR>', opts)
keymap('n', '<leader>rf', ':TestFile<CR>', opts)
keymap('n', '<leader>ra', ':TestSuite<CR>', opts)
keymap('n', '<leader>rl', ':TestLast<CR>', opts)
keymap('n', '<leader>rv', ':TestVisit<CR>', opts)

vim.cmd [[
  let test#strategy = 'neovim'
  let test#neovim#term_position = "bot 15"
]]
