local status_ok, theme = pcall(require, "catppuccin")
if not status_ok then
  return
end

vim.o.background = "dark"

theme.setup {
  transparent_background = false,
  background = {
    light = "latte",
    dark = "macchiato",
  },
  integrations = {
    cmp = {
      enabled = true,
      border = {
        completion = true,
        documentation = true,
      },
    },
  },
  custom_highlights = function(color)
    if vim.o.background == "light" then
      return {
        TabLineSel = { fg = color.base, bg = color.blue },
        TabLineFill = { bg = color.base },
        TabLine = { fg = color.text, bg = color.base },
      }
    else
      return {
        TabLineSel = { fg = color.text, bg = color.none },
        TabLineFill = { bg = color.mantle },
        TabLine = { fg = color.overlay1, bg = color.mantle },
      }
    end
  end,
}

vim.cmd.colorscheme "catppuccin"
