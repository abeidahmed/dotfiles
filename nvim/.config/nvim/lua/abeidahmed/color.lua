local onedarkpro = require("onedarkpro")
local utils = require("onedarkpro.utils")
local colors = require("onedarkpro").get_colors()

vim.o.background = "dark"

-- vim.cmd [[colorscheme onedarkpro]]

-- vim.cmd [[hi DiagnosticError guifg=#f87171]]
-- vim.cmd [[hi DiagnosticWarn guibg=#2e3440]]
-- vim.cmd [[hi DiagnosticInfo guibg=#2e3440]]
-- vim.cmd [[hi DiagnosticHint guibg=#2e3440]]

-- vim.cmd [[hi LineNr guifg=#64748b]]
-- vim.cmd [[hi CursorLineNr guifg=#EBCB8B]]

onedarkpro.setup {
  plugins = {
    polyglot = false,
  },
  options = {
    italic = false,
  },
  hlgroups = {
    TabLineSel = { fg = colors.black, bg = colors.green },
    TabLineFill = { bg = utils.lighten(colors.bg, 0.95) },
    TabLine = { bg = utils.lighten(colors.bg, 0.95) }
  },
}

onedarkpro.load()
