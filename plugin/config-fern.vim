vim9script
g:fern#renderer = 'nerdfont'

# Fern customization
function InitFern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden)
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call InitFern()
augroup END
