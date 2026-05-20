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

Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'vim-test/vim-test'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'hrsh7th/vim-vsnip'
Plug 'tpope/vim-rails'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" vim-fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ga :Git commit --amend<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gt :Git difftool<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

" vim-test
nnoremap <leader>rt :TestNearest<CR>
nnoremap <leader>rf :TestFile<CR>
nnoremap <leader>ra :TestSuite<CR>
nnoremap <leader>rl :TestLast<CR>
nnoremap <leader>rv :TestVisit<CR>

" Ctrl + h/j/k/l navigates between window splits and tmux panes.
" Mappings are provided by vim-tmux-navigator; don't override them here.

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

" Quickfix list
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" Netrw
nnoremap <leader>n :Explore<CR>

" vim-vsnip
" Set custom snippets directory
let g:vsnip_snippet_dir = expand('~/.vim/snippets')
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.eruby = ['html']
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
" Expand
imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>'
smap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>'
" Jump forward or backward
imap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

" Alacritty supports true color but vim can't auto-detect it
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Source the current theme
if filereadable(expand("~/.vim/theme.vim"))
  source ~/.vim/theme.vim
endif

" Copy current buffer's path relative to the project directory
command! CopyPath let @+ = expand('%:p')

" Mark jbuilder and axlsx files as ruby
autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
autocmd BufRead,BufNewFile *.axlsx set filetype=ruby

" Trim trailing whitespace and empty lines at EOF on save
function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  keeppatterns %s/\n\+\%$//e
  call winrestview(l:save)
endfunction

autocmd BufWritePre * call TrimWhitespace()

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>sg :Rg<CR>

" Send selected fzf entries to the quickfix list (parses :Rg's file:line:col:text)
function! s:build_quickfix_list(lines)
  let l:items = map(copy(a:lines), {_, line ->
    \ matchlist(line, '\v^([^:]+):(\d+):(\d+):(.*)$') is# [] ?
    \   { 'filename': line, 'lnum': 1 } :
    \   { 'filename': matchstr(line, '\v^[^:]+'),
    \     'lnum':     str2nr(matchstr(line, '\v^[^:]+:\zs\d+')),
    \     'col':      str2nr(matchstr(line, '\v^[^:]+:\d+:\zs\d+')),
    \     'text':     matchstr(line, '\v^[^:]+:\d+:\d+:\zs.*') }
    \ })
  call setqflist(l:items)
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all,ctrl-d:deselect-all'

" Quickly find the rails partial usages across the codebase
command! FindPartialUsages
  \ let s:partial = substitute(fnamemodify(expand('%:t:r'), ':r'), '^_', '', '') |
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case "render\b.*([\"''/]' . s:partial . '[\"'']|@' . s:partial . '(es|s)?\b)" app/views/ app/helpers/',
  \   1,
  \   fzf#vim#with_preview(),
  \   0
  \ )
