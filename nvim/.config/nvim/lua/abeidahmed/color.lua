local status_ok, onedarkpro = pcall(require, "onedarkpro")
if not status_ok then
  return
end

local utils = require("onedarkpro.utils")
local colors = onedarkpro.get_colors()

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
    aerial = false,
    barbar = false,
    dashboard = false,
    gitsigns_nvim = true,
    hop = false,
    indentline = false,
    lsp_saga = false,
    marks = false,
    native_lsp = true,
    neo_tree = false,
    notify = false,
    nvim_cmp = true,
    nvim_dap = false,
    nvim_dap_ui = false,
    nvim_hlslens = false,
    nvim_tree = true,
    nvim_ts_rainbow = false,
    packer = false,
    polygot = false,
    startify = false,
    telescope = false,
    toggleterm = false,
    treesitter = true,
    trouble_nvim = false,
    vim_ultest = false,
    which_key_nvim = false,
  },
  options = {
    italic = false,
  },
  hlgroups = {
    -- General
    NormalFloat = { bg = colors.black }, -- Text inside a floating window
    -- TabLine
    TabLineSel = { fg = colors.black, bg = colors.green },
    TabLineFill = { bg = utils.lighten(colors.bg, 0.95) },
    TabLine = { bg = utils.lighten(colors.bg, 0.95) },
    -- Telescope
    TelescopeResultsTitle = { fg = colors.black, bg = colors.purple },
    TelescopeBorder = { fg = colors.comment },
    TelescopePromptPrefix = { fg = colors.purple },
    TelescopeMatching = { fg = colors.purple },
    TelescopeSelection = { bg = utils.lighten(colors.bg, 0.92) },
  },
  colors = {
    fg_gutter = utils.lighten(colors.bg, 0.95),
  },
}

onedarkpro.load()
