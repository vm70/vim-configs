" Install Conditions {{{

if executable('npm')
  finish
endif

call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')

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
