if filereadable($VIMRUNTIME . '/pack/dist/opt/comment/plugin/comment.vim')
  packadd comment
else
  call minpac#add('tpope/vim-commentary')
endif
