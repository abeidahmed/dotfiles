require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    disable = { 'ruby' },
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { 'ruby', 'yaml' },
  },
}
