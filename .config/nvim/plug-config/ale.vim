let g:ale_fix_on_save = 1 " To fix on save
let g:ale_disable_lsp = 1 " Disable so that coc completion can work
let g:airline#extensions#ale#enabled = 1 " Show errors on airline

" Navigation between errors
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
