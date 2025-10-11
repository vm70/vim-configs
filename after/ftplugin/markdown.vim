vim9script
setlocal spelloptions=
setlocal wrap

setlocal conceallevel=0

inoremap <buffer> <C-BS> <C-W>
inoremap <buffer> <S-Tab> <cmd><<CR>
vnoremap <buffer> <S-Tab> <gv
vnoremap <buffer> <Tab> >gv

g:markdown_folding = 1
