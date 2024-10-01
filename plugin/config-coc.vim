" Install Conditions {{{

if !executable('npm')
  finish
endif

call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('honza/vim-snippets')

" }}}
" Globals {{{

let g:coc_global_extensions = ['coc-ltex', 'coc-snippets', '@yaegassy/coc-pylsp', '@yaegassy/coc-ruff', 'coc-prettier', 'coc-yaml', 'coc-toml']
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" }}}
" Settings {{{

set nobackup
set nowritebackup
set updatetime=300

" }}}
" Functions {{{

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" }}}
" Keymaps {{{

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>cc <Plug>(coc-codelens-action)
nmap <leader>cf <Plug>(coc-format)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>xx <cmd>CocDiagnostics<CR>
nmap <silent> <leader>r <Plug>(coc-codeaction-refactor)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
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

" }}}
" Commands {{{

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" }}}
