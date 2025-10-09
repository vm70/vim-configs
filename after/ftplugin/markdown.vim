vim9script
setlocal spelloptions=
setlocal wrap

setlocal conceallevel=0

inoremap <C-BS> <C-W>
inoremap <S-Tab> <cmd><<CR>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

g:markdown_folding = 1
