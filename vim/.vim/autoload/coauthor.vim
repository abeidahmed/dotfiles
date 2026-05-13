if exists('g:autoloaded_coauthor') | finish | endif
let g:autoloaded_coauthor = 1

function! s:ReadEntries() abort
  let file = get(g:, 'coauthor_file', expand('~/.config/git/coauthors'))
  if !filereadable(file)
    return []
  endif
  return filter(readfile(file), 'v:val =~# ''\S''')
endfunction

function! coauthor#Complete(findstart, base) abort
  let line = getline('.')

  " Only activate on Co-authored-by: trailer lines
  if line !~# '^\s*Co-authored-by:\s'
    if a:findstart
      return -3  " -3 = cancel silently without falling back
    endif
    return []
  endif

  if a:findstart
    " Start completion after 'Co-authored-by: '
    let start = matchend(line, '^\s*Co-authored-by:\s\+')
    return start == -1 ? col('.') - 1 : start
  endif

  " Filter entries by base (matches name or email)
  let entries = s:ReadEntries()
  if empty(a:base)
    return entries
  endif
  return filter(copy(entries), 'v:val =~? escape(a:base, "\\[]^$.*~")')
endfunction
