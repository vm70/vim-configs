setlocal conceallevel=0
setlocal nospell

command! SortJSON :execute ':%!jq -S .'
