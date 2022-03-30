vim.g.nvim_tree_indent_markers = 1

local nvim_tree = require 'nvim-tree'
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local list = {
  { key = 'x', cb = tree_cb('close_node') },
}

nvim_tree.setup {
  auto_close = true,
  view = {
    auto_resize = true,
    mappings = {
      list = list,
    },
  },
  filters = {
    custom = { '*.tmp', '.git' },
  },
}

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
