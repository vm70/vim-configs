call minpac#add('jpalardy/vim-slime', {'type': 'opt'})

let g:slime_target = has('nvim') ? 'neovim' : 'vimterminal'

augroup repl
  autocmd!
  autocmd BufReadPre *.py packadd vim-slime
  autocmd BufReadPre *.jl packadd vim-slime
augroup END

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
