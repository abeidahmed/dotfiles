local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.hidden = true
opt.scrolloff = 8
opt.hlsearch = false
opt.termguicolors = true
opt.colorcolumn = "121"
-- opt.background = "dark" -- present in color.lua
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.cursorline = true
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.incsearch = true
opt.signcolumn = "yes"
opt.updatetime = 1000
opt.clipboard = { "unnamedplus", "unnamed" }
opt.mouse = "nv"
opt.mousemodel = ""
opt.cmdheight = 2
opt.conceallevel = 0
opt.completeopt = { "menu", "menuone", "noselect" }
opt.guicursor = ""
opt.belloff = "all"

-- Cool floating window popup menu for completion on command line
opt.pumblend = 0 -- Disable transparency on popup menu
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.shortmess:append "c"

opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

opt.joinspaces = false
