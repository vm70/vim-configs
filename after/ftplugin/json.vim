vim9script
setlocal conceallevel=0
setlocal nospell

if executable('jq')
  command! SortJSON :execute ':%!jq -S'
endif
