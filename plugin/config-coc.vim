" Run Conditions {{{

if !executable('npm')
  finish
endif

let g:airline#extensions#coc#enabled = 1
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-ltex',
      \ 'coc-lua',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ ]

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

function CocInit()

  set nobackup
  set nowritebackup
  set updatetime=300
  set tagfunc=CocTagFunc

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Triggering completion is done with <C-y> (see `:help ins-completion`)
  nmap <leader>ca <Plug>(coc-codeaction-selected)
  nmap <leader>cc <Plug>(coc-codelens-action)
  nmap <leader>cf <Plug>(coc-format)
  nmap <leader>cr <Plug>(coc-rename)
  nmap <leader>qf <Plug>(coc-fix-current)
  nmap <leader>xX <cmd>CocList diagnostics<CR>
  nmap <leader>xx <cmd>CocDiagnostics<CR>
  nmap <silent> <leader>r <Plug>(coc-codeaction-refactor)
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD <Plug>(coc-declaration)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gy <Plug>(coc-type-definition)
  nnoremap <silent> K :call ShowDocumentation()<CR>
  omap ac <Plug>(coc-classobj-a)
  omap af <Plug>(coc-funcobj-a)
  omap ic <Plug>(coc-classobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap <leader>ca <Plug>(coc-codeaction-selected)
  xmap <leader>cf <Plug>(coc-format-selected)
  xmap <silent> <leader>r <Plug>(coc-codeaction-refactor-selected)
  xmap ac <Plug>(coc-classobj-a)
  xmap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  xmap if <Plug>(coc-funcobj-i)

  command! -nargs=0 CocFormat :call CocActionAsync('format')

  if executable('clangd')
    call coc#config('languageserver.clangd', {
          \ 'command': '/usr/bin/clangd',
          \ 'filetypes': ['c', 'cc', 'cpp', 'c++', 'objc', 'objcpp'],
          \ 'rootPatterns': ['compile_flags.txt', 'compile_commands.json']
          \ })
  endif

  if executable('efm-langserver')
    call coc#config('languageserver.clangd', {
          \ 'command': '/usr/bin/efm-langserver',
          \ 'filetypes': ['lua', 'vim'],
          \ 'rootPatterns': ['.git', 'selene.toml', 'vimrc', 'init.vim']
          \ })
  endif

  if executable('gopls')
    call coc#config('languageserver.clangd', {
          \ 'command': '/usr/bin/gopls',
          \ 'filetypes': ['go'],
          \ 'rootPatterns': ['go.mod']
          \ })
  endif

  if executable('clangd')
    call coc#config('languageserver.pylsp', {
          \ 'command': '/usr/bin/pylsp',
          \ 'filetypes': ['python'],
          \ 'rootPatterns': ['pyproject.toml', '.git']
          \ })
  endif

  if executable('stylua')
    call coc#config('languageserver.stylua', {
          \ 'args': ['--lsp'],
          \ 'command': '$HOME/.cargo/bin/stylua',
          \ 'filetypes': ['lua']
          \ })
  endif

  if executable('taplo')
    call coc#config('languageserver.taplo', {
          \ 'args': ['lsp', 'stdio'],
          \ 'command': '$HOME/.cargo/bin/taplo',
          \ 'filetypes': ['toml']
          \ })
  endif
endfunction


augroup coc_init
  autocmd!
  autocmd User CocNvimInit call CocInit()
augroup END
