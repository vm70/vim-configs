vim9script

g:fern#renderer = 'nerdfont'

if !executable('trash')
  echohl WarningMsg
  echo 'WARNING: trash-cli not installed'
  echohl None
endif

# Toggle file tree, current directory
nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR>
# Toggle file tree, parent of current file
nnoremap <leader>E <cmd>Fern %:h -toggle -drawer<CR>

# Fern customization
function InitFern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden)
  if !executable('trash')
    nmap <buffer> <Plug>(my-trash) <Plug>(fern-action-trash=)y<CR>
  endif
endfunction

augroup customize-fern
  autocmd! *
  autocmd FileType fern call InitFern()
augroup END
