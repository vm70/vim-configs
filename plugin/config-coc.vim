" Run Conditions {{{

if !executable('npm')
  finish
endif

let g:airline#extensions#coc#enabled = 1
let g:coc_global_extensions = [
      \ 'coc-json',
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
  command! -nargs=0 Snippets :CocList snippets

  " Update efm-langserver's args to point to $HOME/.vim/efm-config.yaml
  call coc#config('languageserver.efm.args', ['-c', expand('$MYVIMDIR/efm-config.yaml')])

  " Enable servers if they are executable
  for [server, options] in items(coc#util#get_config('languageserver'))
    if executable(options['command'])
      call coc#config('languageserver.' . server . '.enable', v:true)
    endif
  endfor

endfunction


augroup coc_init
  autocmd!
  autocmd User CocNvimInit call CocInit()
augroup END
