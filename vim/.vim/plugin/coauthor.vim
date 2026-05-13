if exists('g:loaded_coauthor') | finish | endif
let g:loaded_coauthor = 1

" Path to your coauthors file. Override with:
"   let g:coauthor_file = '/path/to/your/file'
if !exists('g:coauthor_file')
  let g:coauthor_file = expand('~/.config/git/coauthors')
endif

function! s:SetUp() abort
  if &omnifunc ==# '' || &omnifunc ==# 'syntaxcomplete#Complete'
    setlocal omnifunc=coauthor#Complete
  endif
endfunction

augroup coauthor
  autocmd!
  autocmd FileType gitcommit call s:SetUp()
augroup END
