vim9script

def VimCompleteSetup()

  set formatexpr=lsp#lsp#FormatExpr()
  set keywordprg=:LspHover
  set tagfunc=lsp#lsp#TagFunc

  g:LspOptionsSet({
        \ 'autoComplete': v:false,
        \ 'omniComplete': v:false,
        \ })

  g:VimCompleteOptionsSet({
        \ 'vsnip': {'enable': v:true}
        \ })

  if executable('typescript-language-server')
    g:LspAddServer([{
          \ 'name': 'tsserver',
          \ 'filetype': ['typescript', 'javascript'],
          \ 'path': 'typescript-language-server',
          \ 'args': ['--stdio']
          \ }])
  endif

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

  if executable('taplo')
    g:LspAddServer([{
          \ 'name': 'taplo',
          \ 'filetype': ['toml'],
          \ 'path': 'taplo',
          \ 'args': ['lsp', 'stdio'],
          \ }])
  endif

  if executable('efm-langserver')
    g:LspAddServer([{
          \ 'name': 'efm-langserver',
          \ 'filetype': ['vim', 'lua', 'markdown', 'json', 'pandoc', 'markdown.pandoc'],
          \ 'path': 'efm-langserver',
          \ 'args': ['-c', expand('$MYVIMDIR/efm-config.yaml')]
          \ }])
  endif

  if executable('ltex-ls-plus')
    g:LspAddServer([{
          \ 'name': 'ltex-ls-plus',
          \ 'filetype': ['bib', 'context', 'gitcommit', 'html', 'markdown', 'markdown.pandoc', 'org', 'pandoc', 'plaintex', 'quarto', 'mail', 'mdx', 'rmd', 'rnoweb', 'rst', 'tex', 'text', 'typst', 'xhtml'],
          \ 'path': 'ltex-ls-plus',
          \ 'initializationOptions': {
          \   'settings': {
          \     'ltex': {
          \       'enabled': [
          \         'bib',
          \         'context',
          \         'gitcommit',
          \         'html',
          \         'markdown',
          \         'org',
          \         'pandoc',
          \         'plaintex',
          \         'quarto',
          \         'mail',
          \         'mdx',
          \         'rmd',
          \         'rnoweb',
          \         'rst',
          \         'tex',
          \         'latex',
          \         'text',
          \         'typst',
          \         'xhtml',
          \       ],
          \     }
          \   }
          \ },
          \ }])
  endif

  nmap <leader>cc <cmd>LspCodeLens<CR>
  nmap <leader>cf <cmd>LspFormat<CR>
  nmap <leader>xX <cmd>LspDiagShow<CR>
  nmap <leader>xx <cmd>LspDiagShow<CR>
  nmap [d <cmd>LspDiagPrev<CR>
  nmap ]d <cmd>LspDiagNext<CR>
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

  # Expand
  imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
  smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

  # Expand or jump
  imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  # Jump forward or backward
  imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
  smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
enddef

augroup vimcomplete_setup
  autocmd!
  autocmd VimEnter * call VimCompleteSetup()
augroup END

