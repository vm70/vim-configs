" Install Conditions {{{

if filereadable($VIMRUNTIME . '/pack/dist/opt/comment/plugin/comment.vim')
  packadd comment
else
  call minpac#add('tpope/vim-commentary')
endif

" }}}
" Keymaps {{{

" Commenting with Ctrl-/
vmap <C-_> gc<CR>k
nmap <C-_> <C-v>gc<CR>k

" }}}
