local onedarkpro = require("onedarkpro")

vim.o.background = "dark"
-- vim.g.nord_italic = false
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = true
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
}

onedarkpro.load()
