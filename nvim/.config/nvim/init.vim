syntax on
filetype plugin on

set nu
set relativenumber
set hidden
set scrolloff=8
set noerrorbells
set noru
set nohlsearch
set termguicolors
set colorcolumn=121
set background=dark
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set cursorline
set smartindent
set nowrap
set noswapfile
set nobackup
set nowritebackup
set incsearch
set signcolumn=yes
set updatetime=50
set shortmess+=c " coc recommended
set clipboard=unnamedplus,unnamed
set mouse=a
set cmdheight=2
set completeopt=menu,menuone,noselect

call plug#begin('~/.vim/plugged')

Plug 'kyazdani42/nvim-tree.lua'
Plug 'numToStr/Comment.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'nvim-lualine/lualine.nvim'
" Ruby/Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
" Vue
Plug 'posva/vim-vue'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Fuzzy finders
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" LSP and autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
" Visuals
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Trim trailing white spaces on save
fun! TrimWhiteSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup HAWAABI
  autocmd!
  autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

" Indent p tag
let g:html_indent_inctags = 'p'

lua require('abeidahmed')
