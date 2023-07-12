-- local status_ok, onedarkpro = pcall(require, "onedarkpro")
-- if not status_ok then
--   return
-- end
--
-- local utils = require("onedarkpro.lib.color")
-- local colors = onedarkpro.get_colors()

vim.o.background = "light"

require("catppuccin").setup {
  background = {
    light = "latte"
  },
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
}

vim.cmd.colorscheme "catppuccin"

-- vim.cmd [[hi DiagnosticError guifg=#f87171]]
-- vim.cmd [[hi DiagnosticWarn guibg=#2e3440]]
-- vim.cmd [[hi DiagnosticInfo guibg=#2e3440]]
-- vim.cmd [[hi DiagnosticHint guibg=#2e3440]]

-- vim.cmd [[hi LineNr guifg=#64748b]]
-- vim.cmd [[hi CursorLineNr guifg=#EBCB8B]]

-- onedarkpro.setup {
--   options = {
--     italic = false,
--     bold = false,
--   },
--   highlights = {
--     -- TabLine
--     TabLineSel = { fg = colors.black, bg = colors.green },
--     TabLineFill = { bg = utils.lighten(colors.bg, 0.95) },
--     TabLine = { bg = utils.lighten(colors.bg, 0.95) },
--   },
-- }
--
-- onedarkpro.load()
