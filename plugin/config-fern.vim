vim9script
g:fern#renderer = 'nerdfont'

nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR> | # Fern: Toggle file tree, current directory
nnoremap <leader>E <cmd>Fern %:h -toggle -drawer<CR> | # Fern: Toggle file tree, parent directory of current file

if !executable('trash')
  echohl WarningMsg
  echo 'WARNING: trash-cli not installed'
  echohl None
endif

# Fern customization
function InitFern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden)
  if !executable('trash')
    nmap <buffer> <Plug>(my-trash) <Plug>(fern-action-trash=)y<CR>
  endif
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call InitFern()
augroup END
