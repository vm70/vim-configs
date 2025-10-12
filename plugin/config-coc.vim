" Run Conditions {{{

if !executable('npm')
  finish
endif

function! CocNvimInit()
  packadd vim-snippets
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
endfunction

augroup my_coc_nvim
  autocmd!
  autocmd User CocNvimInit call CoCNvimInit()
augroup END
