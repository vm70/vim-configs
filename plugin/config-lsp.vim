vim9script
packadd lsp

g:UltiSnipsExpandTrigger = "<C-Y>"
g:UltiSnipsJumpForwardTrigger = "<Tab>"
g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

call LspOptionsSet({
  \ 'snippetSupport': v:true,
  \ 'ultisnipsSupport': v:true,
  \ })

if executable('lua-language-server')
  call LspAddServer([{
    \ 'name': 'lua-language-server',
    \ 'filetype': 'lua',
    \ 'path': 'lua-language-server',
    \ 'rootSearch': ['.luarc.json', '.luarc.jsonc'],
    \ }])
endif

if executable('pylsp')
  call LspAddServer([{
    \ 'name': 'pylsp',
    \ 'filetype': 'python',
    \ 'path': 'pylsp',
    \ 'rootSearch': ['setup.py', 'pyproject.toml'],
    \ }])
endif

if executable('vim-language-server')
  call LspAddServer([{
    \ 'name': 'vimlsp',
    \ 'filetype': 'vim',
    \ 'path': 'vim-language-server',
    \ 'args': ['--stdio'],
    \ 'rootSearch': ['init.vim', 'vimrc'],
    \ }])
endif

if executable('efm-langserver')
  call LspAddServer([{
    \ 'name': 'efm-langserver',
    \ 'filetype': ['vim', 'lua', 'markdown', 'json'],
    \ 'path': 'efm-langserver',
    \ }])
endif
