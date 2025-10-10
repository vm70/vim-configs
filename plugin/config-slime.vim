vim9script
g:slime_target = 'vimterminal'

function SlimeSetup()
  packadd vim-slime
  nnoremap <leader>sc <Plug>SlimeSendCell | " Slime: Send Code Cell
endfunction

augroup repl
  autocmd!
  autocmd BufReadPre *.py,*.jl call SlimeSetup()
augroup END

