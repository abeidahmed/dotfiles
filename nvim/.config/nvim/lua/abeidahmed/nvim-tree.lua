local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local tree_cb = require"nvim-tree.config".nvim_tree_callback

local list = {
  { key = "x", cb = tree_cb("close_node") },
}

nvim_tree.setup {
  view = {
    mappings = {
      list = list,
    },
  },
  filters = {
    custom = {},
    dotfiles = false,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}

vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
