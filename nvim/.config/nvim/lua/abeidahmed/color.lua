return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.o.background = "light"
    require("catppuccin").setup {
      transparent_background = false,
      background = {
        light = "latte",
        dark = "macchiato",
      },
      no_italic = true,
    }

    vim.cmd.colorscheme "catppuccin"
  end,
}
