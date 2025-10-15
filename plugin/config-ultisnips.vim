vim9script

if !has('python3')
  finish
endif

# Use `completefunc` with UltiSnips: https://github.com/SirVer/ultisnips/issues/886

function ListSnippets(findstart, base) abort
  if empty(UltiSnips#SnippetsInCurrentScope(1))
    return ''
  endif
  
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && (line[start - 1] =~? '\a')
      let start -= 1
    endwhile
    return start
  else
    " find classes matching "a:base"
    let res = []
    for m in keys(g:current_ulti_dict_info)
      if m =~ a:base
        let n = {
              \ 'word': m,
              \ 'menu': '[snip] ' .. g:current_ulti_dict_info[m]['description']
              \ }
        call add(res, n)
      endif
    endfor
    return res
  endif
endfunction

g:UltiSnipsExpandTrigger = '<C-Y>'
g:UltiSnipsJumpForwardTrigger = '<Tab>'
g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  
packadd ultisnips
packadd vim-snippets

set completefunc=ListSnippets
