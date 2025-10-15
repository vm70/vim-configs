vim9script

setlocal conceallevel=0
setlocal linebreak
setlocal spelloptions=
setlocal wrap

inoremap <buffer> <C-BS> <C-W>
inoremap <buffer> <S-Tab> <cmd><<CR>
vnoremap <buffer> <S-Tab> <gv
vnoremap <buffer> <Tab> >gv

g:markdown_folding = 1
