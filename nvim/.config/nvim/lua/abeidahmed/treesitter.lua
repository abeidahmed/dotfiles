local status_ok, config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

config.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "yaml", "ruby" },
  },
  endwise = {
    enable = true,
  },
}
