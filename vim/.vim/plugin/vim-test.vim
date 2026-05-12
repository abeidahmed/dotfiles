" vim-test monorepo setup
function! VimTestProjectRoot()
  let l:markers = {
    \ 'ruby': 'Gemfile.lock',
    \ 'go': 'go.mod',
    \ 'typescript': 'package.json',
    \ 'typescriptreact': 'package.json',
    \ 'javascript': 'package.json',
    \ 'javascriptreact': 'package.json',
    \ }
  let l:marker = get(l:markers, &filetype, '')
  if empty(l:marker)
    return getcwd()
  endif
  let l:found = findfile(l:marker, '.;')
  return empty(l:found) ? getcwd() : fnamemodify(l:found, ':p:h')
endfunction

let test#project_root = 'VimTestProjectRoot'

function! VimTestUseBinTest() abort
  let l:bin = findfile('bin/test', '.;')
  if !empty(l:bin)
    let l:abs = fnamemodify(l:bin, ':p')
    let g:test#ruby#rails#executable = l:abs
  endif
endfunction

augroup VimTestBinTest
  autocmd!
  autocmd BufEnter,BufRead,BufNewFile *.rb call VimTestUseBinTest()
augroup END

" Use dispatch
let test#strategy = 'dispatch'
