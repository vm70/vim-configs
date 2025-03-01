scriptencoding utf8

" Globals {{{

if exists('g:glyph_palette#defaults#palette')
  let g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)
  let g:glyph_palette#palette['GlyphPalette1'] += ['']
  let g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗']
  let g:glyph_palette#palette['GlyphPalette7'] += ['']
  let g:nerdfont#path#basename#customs = { 'go.mod':'', 'go.sum': '', 'pyproject.toml': ''}
  let g:nerdfont#path#extension#customs = {'yml': '', 'yaml': '', 'go': '', 'qmd':'󰐗','rkt': ''}
endif


" }}}
" Autocommands {{{

" Apply glyph-palette to Coc-Explorer windows
augroup glyph-palette
  autocmd! *
  autocmd FileType coc-explorer call glyph_palette#apply()
  autocmd FileType fern call glyph_palette#apply()
augroup END

" }}}
