let g:ale_fix_on_save = 1 " To fix on save
"let g:ale_disable_lsp = 1 " Disable so that coc completion can work
let g:airline#extensions#ale#enabled = 1 " Show errors on airline

let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'css': ['prettier', 'stylelint']
      \ }

let g:ale_linters = {
                  \ 'typescript': ['eslint', 'stylelint'],
                  \ 'javascript': ['eslint', 'stylelint'],
                  \ 'handlebars': ['embertemplatelint']
                  \}

let g:ale_sign_warning = '😭'
let g:ale_sign_error = '❌'
