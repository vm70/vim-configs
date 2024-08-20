set encoding=utf8
scriptencoding utf8

" Global Variables {{{

" Vim Global Variables
let g:filetype_md = 'markdown.pandoc'
let g:markdown_folding = 1
let mapleader = ' '

" Plugin Global Variables
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:coc_global_extensions = ['coc-ltex', 'coc-snippets', '@yaegassy/coc-pylsp', '@yaegassy/coc-ruff', 'coc-prettier']
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
let g:fern#renderer = 'nerdfont'
let g:fzf_vim = {}
let g:fzf_vim.tags_command = '!rg --files | ctags -R -L -'
let g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']
let g:polyglot_disabled = ['ftdetect', 'markdown', 'quarto', 'json']
let g:slime_target = has('nvim') ? 'neovim' : 'vimterminal'

" }}}
" Options {{{

" Visuals
set background=dark
set conceallevel=2
set cursorline
set list
set number
set title
set termguicolors

" Editing
set autoindent
set autoread
set foldlevelstart=6
set foldmethod=marker
set incsearch
set linebreak
set mouse=a
set signcolumn=yes
set spell
set spelllang=en_us
set spelloptions=camel

" Window Splitting
set splitbelow
set splitright

" Tabs
set noexpandtab
set tabstop=2
set shiftwidth=2

filetype plugin on

" }}}
" Package Setup {{{

" Bootstrap Minpac
let config_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(config_dir.'/pack/minpac/opt/minpac'))
  silent execute '!git clone https://github.com/k-takata/minpac.git '.config_dir.'/pack/minpac/opt/minpac'
endif

" Let Minpac manage itself
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
" User Interface
call minpac#add('Freed-Wu/airline-renderer-nerdfont.vim', {'name': 'vim-airline-nerdfont'})
call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')
call minpac#add('vim-airline/vim-airline')
" Editing
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tpope/vim-surround')
packadd comment " call minpac#add('tpope/vim-commentary')
" REPL / Jupyter call
call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
call minpac#add('jupyter-vim/jupyter-vim', {'type': 'opt'})
" Version Control
call minpac#add('tpope/vim-fugitive')
call minpac#add('rbong/vim-flog')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tpope/vim-rhubarb')
" LSP, Linting, Formatting, Autocompletion
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('honza/vim-snippets')
" Fuzzy Finding
call minpac#add('junegunn/fzf.vim')
" Markdown Preview
call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})

augroup repl
  autocmd!
  autocmd BufReadPre *.py packadd jupyter-vim vim-slime
  autocmd BufReadPre *.jl packadd jupyter-vim vim-slime
augroup END

augroup glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" }}}
" Keymaps {{{

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

" Missing prev- and next- commands
nmap [b <cmd>bprevious<CR>
nmap ]b <cmd>bNext<CR>
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)
nmap [h <cmd>GitGutterPrevHunk<CR>
nmap ]h <cmd>GitGutterNextHunk<CR>
nmap [t <cmd>tabprevious<CR>
nmap ]t <cmd>tabnext<CR>

" Moving lines up and down in code
inoremap <A-j> <cmd>m.+1<CR>==gi
inoremap <A-k> <cmd>m.-2<CR>==gi
nnoremap <A-j> <cmd>m.+1<CR>==
nnoremap <A-k> <cmd>m.-2<CR>==
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv

" Commenting with Ctrl-/
vmap <C-_> gc<CR>k
nmap <C-_> <C-v>gc<CR>k

" LSP Keymaps
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>cf <Plug>(coc-format)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>xx <cmd>CocDiagnostics<CR>
nmap gD <Plug>(coc-declaration)
nmap gd <Plug>(coc-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap gy <Plug>(coc-type-definition)
nnoremap K <cmd>call ShowDocumentation()<CR>
xmap <leader>ca <Plug>(coc-codeaction-selected)

" LSP Text Objects
omap ac <Plug>(coc-classobj-a)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap if <Plug>(coc-funcobj-i)
xmap ac <Plug>(coc-classobj-a)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap if <Plug>(coc-funcobj-i)

" Toggle File Tree
nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR>

" Remove hlsearch by pressing escape twice
nnoremap <Esc><Esc> <cmd>nohlsearch<CR>

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc <cmd>JupyterSendCell<CR>


" }}}
" Commands {{{

command! Vimrc :edit $MYVIMRC
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

silent! colorscheme retrobox

" }}}
