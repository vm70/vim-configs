" Run Conditions {{{

if executable('npm')
  finish
endif

" }}}
" Globals {{{

let g:fern#renderer = 'nerdfont'

" }}}
" Keymaps {{{

" Toggle File Tree
nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR>
nnoremap <leader>E <cmd>Fern %:h -toggle -drawer<CR>

" }}}
" Autocommands {{{

" Fern customization
function! s:init_fern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" }}}
