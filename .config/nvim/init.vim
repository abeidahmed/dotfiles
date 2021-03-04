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
set undodir=~/.vim/undodir
set undofile
set incsearch
set signcolumn=yes
set updatetime=50
set shortmess+=c " coc recommended
set clipboard=unnamedplus,unnamed
set mouse=a
set cmdheight=2

" Plugins
call plug#begin('~/.vim/plugged')

" Addons
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" Ruby, rails related stuff
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
" Theme
Plug 'morhetz/gruvbox'
" Linter
Plug 'dense-analysis/ale'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Tmux
Plug 'christoomey/vim-tmux-navigator'
" JS
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

let mapleader=" "

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

" Toggle NERDCommenter with Ctrl + /
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" Allow Ctrl + movements to navigate between window splits
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" Remaps
nnoremap <Tab> %
nmap <leader>do <Plug>(coc-codeaction)

source $HOME/.config/nvim/color-scheme/color.vim
source $HOME/.config/nvim/plug-config/ale.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/vim-fugitive.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim
source $HOME/.config/nvim/plug-config/airline.vim

