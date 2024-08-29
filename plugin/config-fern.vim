scriptencoding utf8

call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')

let g:fern#renderer = 'nerdfont'
let g:nerdfont#path#extension#customs = {'yml': '', 'yaml': ''}

" Toggle File Tree
nnoremap <leader>e <cmd>Fern %:h -toggle -drawer<CR>

augroup glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END
