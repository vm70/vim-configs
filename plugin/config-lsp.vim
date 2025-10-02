" LSP Options {{{

packadd lsp
call LspOptionsSet({
  \ 'snippetSupport': v:true,
  \ 'vsnipSupport': v:true,
  \ })

" }}}
" Settings {{{

set keywordprg=:LspHover

" }}}
" Keymaps {{{

" Triggering completion is done with <C-y> (see `:help ins-completion`)
nmap <leader>cc <cmd>LspCodeAction<CR>
nmap <leader>cf <cmd>LspFormat<CR>
nmap <leader>cr <cmd>LspRename<CR>
nmap <leader>xX <cmd>LspDiagShow<CR>
nmap <leader>xx <cmd>LspDiagShow<CR>
nmap <silent> [d <cmd>LspDiagPrev<CR>
nmap <silent> ]d <cmd>LspDiagNext<CR>
nmap <silent> gd <cmd>LspGotoDefinition<CR>
nmap <silent> gD <cmd>LspGotoDeclaration<CR>
nmap <silent> gi <cmd>LspGotoImpl<CR>
nmap <silent> gy <cmd>LspGotoTypeDef<CR>
xmap <leader>cf <cmd>LspFormat<CR>

" Jump forward or backward in snippet
imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" }}}
" LSP Server Setup {{{

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

" }}}
