vim9script

setlocal colorcolumn=88

if exists('g:loaded_lsp')
  set formatexpr=lsp#lsp#FormatExpr()
  set keywordprg=:LspHover
endif
