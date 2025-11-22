vim9script
scriptencoding utf8

try
  g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)

  filter(g:glyph_palette#palette['GlyphPalette9'], "v:val != ''")

  g:glyph_palette#palette['GlyphPalette1'] += ['']
  g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗', '']
  g:glyph_palette#palette['GlyphPalette7'] += ['']

  g:nerdfont#path#basename#customs = {
        \ 'go.mod': '',
        \ 'go.sum': '',
        \ 'pyproject.toml': '',
        \ }
  g:nerdfont#path#extension#customs = {
        \ 'go': '',
        \ 'iuml': '',
        \ 'mermaid': '󱁉',
        \ 'mmd': '󱁉',
        \ 'pu': '',
        \ 'puml': '',
        \ 'qmd': '󰐗',
        \ 'v': '󰍛',
        \ 'yaml': '',
        \ 'yml': '',
        \ }
catch /^Vim\%((\a\+)\)\=:E121:/
  # Ignore undefined variable errors
endtry

# Apply glyph-palette to Fern windows
augroup glyph-palette
  autocmd! *
    autocmd FileType fern call glyph_palette#apply()
augroup END
