setlocal conceallevel=0

command! SortJSON :execute ':%!jq -S .'
