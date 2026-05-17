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

let Test#project_root = function('VimTestProjectRoot')

" Use dispatch
let test#strategy = 'dispatch'
