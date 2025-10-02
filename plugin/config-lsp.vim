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

if executable('npm') 
  call LspAddServer([{
    \ 'name': 'vimls',
    \ 'filetype': 'vim',
    \ 'path': 'npx',
    \ 'args': ['-y', 'vim-language-server', '--stdio']
    \ }])
endif

if executable('pylsp') 
  call LspAddServer([{
    \ 'name': 'pylsp',
    \ 'filetype': 'python',
    \ 'path': 'pylsp',
    \ 'args': [],
    \ }])
endif
