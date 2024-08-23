call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
call minpac#add('jupyter-vim/jupyter-vim', {'type': 'opt'})

let g:slime_target = has('nvim') ? 'neovim' : 'vimterminal'

augroup repl
  autocmd!
  autocmd BufReadPre *.py packadd jupyter-vim vim-slime
  autocmd BufReadPre *.jl packadd jupyter-vim vim-slime
augroup END

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc <cmd>JupyterSendCell<CR>
