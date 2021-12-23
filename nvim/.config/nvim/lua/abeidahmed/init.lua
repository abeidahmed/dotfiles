require('abeidahmed.settings')
require('abeidahmed.keymaps')
require('abeidahmed.color')
require('abeidahmed.telescope')
require('abeidahmed.lualine')
require('abeidahmed.nvim-lsp')
require('abeidahmed.nvim-cmp')
require('abeidahmed.vim-vue')
require('abeidahmed.comment')
require('abeidahmed.nvim-tree')
require('abeidahmed.vim-fugitive')

vim.cmd [[
  augroup visual
    autocmd!
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
  augroup end
]]
