scriptencoding utf8

call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')

" Globals {{{

let g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)
let g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗']
let g:glyph_palette#palette['GlyphPalette7'] += ['']
let g:nerdfont#path#basename#customs = { 'go.mod':'', 'go.sum': ''}
let g:nerdfont#path#extension#customs = {'yml': '', 'yaml': '', 'go': '', 'qmd':'󰐗'}

" }}}
" Keymaps {{{


" }}}
" Autocommands {{{

" Apply glyph-palette to Coc-Explorer windows
augroup glyph-palette
  autocmd! *
  autocmd FileType coc-explorer call glyph_palette#apply()
augroup END

" }}}
