local status_ok, config = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

config.setup {
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
  textobjects = {
    move = {
      enabled = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
      }
    }
  },
  endwise = {
    enable = true,
  },
}
