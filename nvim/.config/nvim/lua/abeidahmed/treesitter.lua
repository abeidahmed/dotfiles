require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  sync_install = false,
  highlight = {
    enable = true,
    disable = { 'ruby' },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { 'ruby', 'vue' },
  },
}
