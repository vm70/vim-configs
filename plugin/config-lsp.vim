packadd lsp

set keywordprg=:LspHover

call LspOptionsSet({
  \ 'snippetSupport': v:true,
  \ 'vsnipSupport': v:true,
  \ })

" Jump forward or backward in snippet
imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

if executable('gopls')
  call LspAddServer([{
    \ 'name': 'gopls',
    \ 'filetype': ['go'],
    \ 'path': '/usr/bin/gopls',
    \ 'args': []
    \ }])
endif

if executable('clangd')
  call LspAddServer([{
    \ 'name': 'clangd',
    \ 'filetype': ['c', 'cc', 'cpp', 'c++', 'objc', 'objcpp'],
    \ 'path': '/usr/bin/clangd',
    \ }])
endif

if executable('taplo')
  call LspAddServer([{
        \ 'name': 'taplo',
        \ 'args': ['lsp', 'stdio'],
        \ 'filetype': 'toml',
        \ 'path': $HOME . '/.cargo/bin/taplo',
        \ }])
endif

if executable('npm')
  call LspAddServer([{
    \ 'name': 'vimls',
    \ 'filetype': 'vim',
    \ 'path': '/usr/bin/npx',
    \ 'args': ['-y', 'vim-language-server', '--stdio']
    \ }])
endif

if executable('pylsp')
  call LspAddServer([{
    \ 'name': 'pylsp',
    \ 'filetype': 'python',
    \ 'path': '/usr/bin/pylsp',
    \ 'args': [],
    \ }])
endif
