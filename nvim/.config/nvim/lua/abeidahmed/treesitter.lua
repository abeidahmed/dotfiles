local tree_config = require'nvim-treesitter.configs'

tree_config.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  }
}
