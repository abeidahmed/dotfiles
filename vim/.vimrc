syntax on

" Disable Space in normal/visual before setting leader
noremap <Space> <Nop>
let mapleader = " "

" Fix Alt key sequences for vim
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set number
set relativenumber
set nowrap
set belloff=all

set smartcase
set ignorecase

set shiftwidth=2
set softtabstop=2
set scrolloff=8
set splitright
set signcolumn=yes
set clipboard=unnamedplus,unnamed
set cmdheight=2
set colorcolumn=121

set undolevels=1000
set noswapfile

" Indent HTML properly
let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:html_indent_inctags = 'html,body,head,tbody,p,li,dd,dt,h1,h2,h3,h4,h5,h6,blockquote,section'

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'vim-test/vim-test'

call plug#end()

" vim-fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ga :Git commit --amend<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

" vim-test
nnoremap <leader>rt :TestNearest<CR>
nnoremap <leader>rf :TestFile<CR>
nnoremap <leader>ra :TestSuite<CR>
nnoremap <leader>rl :TestLast<CR>
nnoremap <leader>rv :TestVisit<CR>

" Allow Ctrl + movements to navigate between window splits
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-l> <C-W>l

" Stay in visual mode when indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Behave vim
nnoremap <silent> Y y$

" Keeping it centered
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" Move current line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

" Move visual selection up/down
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Sizing window horizontally
nnoremap <silent> <A-,> <C-W>5>
nnoremap <silent> <A-.> <C-W>5

" Persist paste
xnoremap <silent> <leader>p "_dP

" Alacritty supports true color but vim can't auto-detect it
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
colorscheme gruvbox

" Copy current buffer's path relative to the project directory
command! CopyPath let @+ = expand('%:p')

" Mark jbuilder and axlsx files as ruby
autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.axlsx set filetype=ruby
