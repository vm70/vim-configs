vim9script

g:UltiSnipsExpandTrigger = '<C-Y>'
g:UltiSnipsJumpForwardTrigger = '<Tab>'
g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

def LspConfig()

  packadd ultisnips
  packadd vim-snippets

  set formatexpr=lsp#lsp#FormatExpr()
  set keywordprg=:LspHover
  set tagfunc=lsp#lsp#TagFunc

  g:LspOptionsSet({
    \ 'snippetSupport': v:true,
    \ 'ultisnipsSupport': v:true,
    \ 'useBufferCompletion': v:true,
    \ })

  if executable('lua-language-server')
    g:LspAddServer([{
      \ 'name': 'lua-language-server',
      \ 'filetype': 'lua',
      \ 'path': 'lua-language-server',
      \ 'rootSearch': ['.luarc.json', '.luarc.jsonc'],
      \ }])
  endif

  if executable('pylsp')
    g:LspAddServer([{
      \ 'name': 'pylsp',
      \ 'filetype': 'python',
      \ 'path': 'pylsp',
      \ 'rootSearch': ['setup.py', 'pyproject.toml'],
      \ }])
  endif

  if executable('vim-language-server')
    g:LspAddServer([{
      \ 'name': 'vimlsp',
      \ 'filetype': 'vim',
      \ 'path': 'vim-language-server',
      \ 'args': ['--stdio'],
      \ 'rootSearch': ['init.vim', 'vimrc'],
      \ }])
  endif

  if executable('efm-langserver')
    g:LspAddServer([{
      \ 'name': 'efm-langserver',
      \ 'filetype': ['vim', 'lua', 'markdown', 'json'],
      \ 'path': 'efm-langserver',
      \ }])
  endif

  nmap <leader>[d <cmd>LspDiagPrev<CR>
  nmap <leader>]d <cmd>LspDiagNext<CR>
  nmap <leader>cc <cmd>LspCodeLens<CR>
  nmap <leader>cf <cmd>LspFormat<CR>
  nmap <leader>xX <cmd>LspDiagShow<CR>
  nmap <leader>xx <cmd>LspDiagShow<CR>
  nmap gD <cmd>LspGotoDeclaration<CR>
  nmap gO <cmd>LspDocumentSymbol<CR>
  nmap gd <cmd>LspGotoDefinition<CR>
  nmap gra <cmd>LspCodeAction<CR>
  nmap gri <cmd>LspGotoImpl<CR>
  nmap grn <cmd>LspRename<CR>
  nmap grr <cmd>LspShowReferences<CR>
  nmap grt <cmd>LspGotoTypeDef<CR>
  vmap gra <cmd>LspCodeAction<CR>
  xmap <leader>ca <cmd>LspCodeAction<CR>
  xmap <leader>cf <cmd>LspFormat<CR>
enddef

augroup lsp_setup
  autocmd!
  autocmd User LspSetup LspConfig()
augroup END
