local nvim_tree = require 'nvim-tree'
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local list = {
  { key = 'x', cb = tree_cb('close_node') },
}

nvim_tree.setup {
  auto_close = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  view = {
    auto_resize = true,
    mappings = {
      list = list,
    },
  },
  quit_on_open = 0,
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
}

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
