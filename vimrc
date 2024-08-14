scriptencoding utf8

" Global Variables {{{

" Vim Global Variables
let g:filetype_md = 'markdown.pandoc'
let g:markdown_folding = 1
let mapleader = ' '

" Plugin Global Variables
let g:UltiSnipsExpandTrigger = '<CR>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:ale_fix_on_save = 1
let g:ale_languagetool_executable='languagetool-commandline'
let g:fern#renderer = 'nerdfont'
let g:fzf_vim = {}
let g:fzf_vim.tags_command = '!rg --files | ctags -R -L -'
let g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']
let g:polyglot_disabled = ['markdown', 'quarto']
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
set encoding=utf-8
set foldlevelstart=6
set foldmethod=marker
set incsearch
set linebreak
set mouse=a
set omnifunc=ale#completion#OmniFunc
set signcolumn=yes
set spell
set spelllang=en_us
set spelloptions=camel

" Window Splitting
set splitbelow
set splitright

" Tabs
set tabstop=2

filetype plugin on

" }}}
" Package Setup {{{

" Bootstrap Minpac
let config_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(config_dir.'/pack/minpac/opt/minpac'))
  silent execute '!git clone https://github.com/k-takata/minpac.git '.config_dir.'/pack/minpac/opt/minpac'
endif

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" User Interface
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
" LSP, Linting, Formatting Integration
call minpac#add('dense-analysis/ale')
" Fuzzy Finding
call minpac#add('junegunn/fzf.vim')
" Autocompletion
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-ultisnips.vim')
" Colors
call minpac#add('gruvbox-community/gruvbox')
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

" Define user commands for updating/cleaning the plugins.
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" }}}
" Keymaps {{{

" Missing prev- and next- commands
noremap [b :bprevious<CR>
noremap ]b :bNext<CR>
noremap [d :ALEPrevious<CR>
noremap ]d :ALENext<CR>
noremap [t :tabprevious<CR>
noremap ]t :tabnext<CR>

" Moving lines up and down in code
inoremap <A-j> <Esc>:m.+1<CR>==gi
inoremap <A-k> <Esc>:m.-2<CR>==gi
nnoremap <A-j> :m.+1<CR>==
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m'<-2<CR>gv=gv

" Commenting with Ctrl-/
vmap <C-_> gc<CR>k
nmap <C-_> <C-v>gc<CR>k

" Toggle File Tree
nnoremap <leader>e :Fern . -toggle -drawer<CR>

" Remove hlsearch by pressing escape twice
nnoremap <Esc><Esc> :nohlsearch<CR>

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc :JupyterSendCell<CR>

" LSP / Linting / Formatting
nnoremap <leader>ca :ALECodeAction<CR>
nnoremap <leader>cf :ALEFix<CR>
nnoremap <leader>cr :ALERename<CR>
nnoremap <leader>xx :ALEPopulateQuickfix<CR>
nnoremap K :ALEHover<CR>
nnoremap gD :ALEGoToDeclaration<CR>
nnoremap gI :ALEGoToImplementation<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gy :ALEGoToTypeDefinition<CR>

" Asyncomplete
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" }}}
" Commands {{{

command! Vimrc :edit $MYVIMRC
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

silent! colorscheme gruvbox

" }}}
