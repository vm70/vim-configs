vim9script
scriptencoding utf8

if exists('g:glyph_palette#defaults#palette')
  g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)
  g:glyph_palette#palette['GlyphPalette1'] += ['']
  g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗']
  g:glyph_palette#palette['GlyphPalette7'] += ['']
  g:nerdfont#path#basename#customs = {
        \ 'go.mod': '',
        \ 'go.sum': '',
        \ 'pyproject.toml': '',
        \ }
  g:nerdfont#path#extension#customs = {
        \ 'go': '',
        \ 'qmd': '󰐗',
        \ 'rkt': '',
        \ 'yaml': '',
        \ 'yml': '',
        \ }
endif

# Apply glyph-palette to Fern windows
augroup glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END
