local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.hidden = true
opt.scrolloff = 8
opt.hlsearch = false
opt.termguicolors = true
opt.colorcolumn = '121'
opt.background = 'dark'
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
opt.signcolumn = 'yes'
opt.updatetime = 50
opt.clipboard = { 'unnamedplus', 'unnamed' }
opt.mouse = 'a'
opt.cmdheight = 2
opt.conceallevel = 0
opt.completeopt = { 'menu', 'menuone', 'noselect' }

opt.shortmess:append "c"
