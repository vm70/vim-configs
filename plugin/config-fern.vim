scriptencoding utf8

call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')

" Globals {{{

let g:fern#renderer = 'nerdfont'
let g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)
let g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗']
let g:glyph_palette#palette['GlyphPalette7'] += ['']
let g:nerdfont#path#basename#customs = { 'go.mod':'', 'go.sum': ''}
let g:nerdfont#path#extension#customs = {'yml': '', 'yaml': '', 'go': '', 'qmd':'󰐗'}

" }}}
" Keymaps {{{

" Toggle File Tree
nnoremap <leader>e <cmd>Fern %:h -toggle -drawer<CR>

" }}}
" Autocommands {{{

" Apply glyph-palette to fern windows
augroup glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END

" Fern customization
function! s:init_fern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" }}}
