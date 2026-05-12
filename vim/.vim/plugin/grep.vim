" Search for a pattern using ripgrep and populate the quickfix list.
" Usage: :Grep <pattern> [rg flags]
" Examples:
"   :Grep def total_adjustment_cents
"   :Grep some_method -- -t ruby
function! RipgrepToQflist(query)
  " --vimgrep outputs file:line:col:text format, which setqflist can parse
  let l:results = systemlist('rg --vimgrep ' . shellescape(a:query))
  if empty(l:results)
    echo "No results for: " . a:query
    return
  endif
  " Replace quickfix list with new results and set a descriptive title
  call setqflist([], 'r', {'title': 'rg: ' . a:query, 'lines': l:results})
  " Open the quickfix window and jump to the first result
  copen
  cfirst
endfunction

command! -nargs=+ Grep call RipgrepToQflist(<q-args>)
