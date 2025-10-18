vim9script

g:slime_target = 'vimterminal'

def SlimeSetup()
  packadd vim-slime
  nnoremap <leader>sc <Plug>SlimeSendCell
enddef

augroup repl
  autocmd!
  autocmd BufReadPre *.py,*.jl call SlimeSetup()
augroup END

