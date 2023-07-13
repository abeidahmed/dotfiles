local status_ok, theme = pcall(require, "catppuccin")
if not status_ok then
  return
end

vim.o.background = "light"

theme.setup {
  transparent_background = false,
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
    return {
      TabLineSel = { fg = color.base, bg = color.blue },
      TabLineFill = { bg = color.base },
      TabLine = { fg = color.text, bg = color.base },
    }
  end,
}

vim.cmd.colorscheme "catppuccin"
