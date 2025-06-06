call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'numToStr/Comment.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-test/vim-test'
Plug 'b0o/SchemaStore.nvim'
Plug 'tpope/vim-dispatch'
" Plug 'github/copilot.vim'
" Ruby/Rails
Plug 'RRethy/nvim-treesitter-endwise'
" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
" Fuzzy finders
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" LSP and autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
" Visuals
Plug 'olimorris/onedarkpro.nvim', {'frozen': 1}
Plug 'nvim-lualine/lualine.nvim'
Plug 'catppuccin/nvim'
" Formatters
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'junegunn/vim-easy-align'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

lua require('abeidahmed')
