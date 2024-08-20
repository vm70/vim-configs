
if executable('pylsp')
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pylsp',
            \ 'cmd': {server_info->['pylsp']},
            \ 'whitelist': ['python'],
            \ })
    augroup END
endif

if executable('vim-language-server')
    augroup LspVim
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'vim-language-server',
            \ 'cmd': {server_info->['vim-language-server', '--stdio']},
            \ 'whitelist': ['vim'],
            \ 'initialization_options': {
            \   'vimruntime': $VIMRUNTIME,
            \   'runtimepath': &rtp,
            \ }})
    augroup END
endif

if executable('lua-language-server')
    augroup LspLua
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'lua-language-server',
            \ 'cmd': {server_info->['lua-language-server']},
            \ 'whitelist': ['lua'],
            \ })
    augroup END
endif

if executable('ruff-lsp')
    augroup LspRuff
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'ruff-lsp',
                    \ 'cmd': {server_info -> ['ruff-lsp']},
                    \ 'whitelist': ['lua'],
                    \ })
    augroup END
endif

if executable('efm-langserver')
    augroup LspEFM
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'efm-langserver',
                    \ 'cmd': {server_info -> ['efm-langserver']},
                    \ 'whitelist': ['vim'],
                    \ })
    augroup END
endif

if executable('marksman')
    augroup LspMD
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'marksman',
                    \ 'cmd': {server_info -> ['marksman', 'server']},
                    \ 'whitelist': ['markdown', 'markdown.pandoc', 'quarto'],
                    \ })
    augroup END
endif

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
      \ }))
