setlocal conceallevel=0
setlocal nospell

if executable('jq')
  setlocal equalprg=jq\ -S\ |
  command! SortJSON :execute ':%!jq -S'
endif
