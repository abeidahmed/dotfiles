require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
    disable = { 'yaml', 'ruby' },
  },
  endwise = {
    enable = true,
  },
}
