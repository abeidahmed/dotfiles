require('abeidahmed.settings')
require('abeidahmed.keymaps')
require('abeidahmed.color')
require('abeidahmed.telescope')
require('abeidahmed.lualine')
require('abeidahmed.lsp')
require('abeidahmed.nvim-cmp')
require('abeidahmed.comment')
require('abeidahmed.nvim-tree')
require('abeidahmed.vim-fugitive')
require('abeidahmed.null-ls')
require('abeidahmed.treesitter')
require('abeidahmed.vim-test')
require('abeidahmed.gsigns')
require('abeidahmed.luasnip')

-- Function taken from https://github.com/norcalli/nvim_utils
function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function trim_whitespace()
  local save = vim.fn.winsaveview()
  vim.api.nvim_exec(string.format("silent! %s", [[%s/\s\+$//e]]), false)
  vim.fn.winrestview(save)
end

-- Autocmds
local autocmds = {
  visual = {
    { 'TextYankPost', '*', "silent!lua require('vim.highlight').on_yank({higroup = 'Substitute', timeout = 150, on_macro = true})" }
  },
  formatter = {
    { 'BufWritePre', '*', 'lua trim_whitespace()' },
  },
}

nvim_create_augroups(autocmds)

-- Miscellaneous
vim.g.html_indent_inctags = 'p'
