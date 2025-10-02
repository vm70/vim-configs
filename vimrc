set encoding=utf8
scriptencoding utf8

" Global Variables {{{

" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
let g:filetype_md = 'markdown.pandoc'
let g:filetype_v = 'verilog'
let mapleader = ' '

" }}}
" Options {{{

" Visuals
set background=dark
set conceallevel=2
set cursorline
set fillchars=vert:│,fold:-,eob:~
set list
set listchars=tab:→\ ,trail:·,nbsp:+
set number
set showbreak=↪\ |
set termguicolors
set title

" Editing
set autoindent
set autoread
set foldlevelstart=6
set foldmethod=marker
set hlsearch
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
set shiftwidth=2
set tabstop=2

" Diff Options
set diffopt=internal,filler,closeoff,vertical

filetype plugin on
syntax on

" }}}
" Package Setup {{{

" Bootstrap Minpac
let config_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(config_dir.'/pack/minpac/opt/minpac'))
  silent execute '!git clone https://github.com/k-takata/minpac.git '.config_dir.'/pack/minpac/opt/minpac'
endif

" Minpac Commands
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" Let Minpac manage itself
packadd! minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Colorscheme
call minpac#add('gruvbox-community/gruvbox')
" Nerd Fonts
call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')
" Status Line
call minpac#add('Freed-Wu/airline-renderer-nerdfont.vim', {'name': 'vim-airline-nerdfont'})
call minpac#add('vim-airline/vim-airline')
" File Tree
call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
" Fuzzy Finding
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/fzf', {'do': 'packloadall! | call fzf#install()'})
" Git integration
call minpac#add('tpope/vim-fugitive')
call minpac#add('airblade/vim-gitgutter')
" Editing
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-sleuth')
" Jupyter/REPL
call minpac#add('jpalardy/vim-slime', {'type': 'opt'})

" Use built-in comment package if available
if has('patch-9.1.375')
  packadd! comment
else
  call minpac#add('tpope/vim-commentary')
endif

if executable('npm')
  " Markdown Preview
  call minpac#add('iamcco/markdown-preview.nvim', {'type': 'opt', 'do': 'packadd! markdown-preview.nvim | call mkdp#util#install()'})
  " LSP Integration, Snippets, Autocompletion
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('honza/vim-snippets')
endif

" Run PackUpdate if there are missing plugins
if len(filter(values(minpac#getpluglist()), '!isdirectory(v:val.dir)'))
  call minpac#update()
endif

" }}}
" Keymaps {{{

" Stop highlight search
nnoremap <Esc><Esc> <cmd>nohlsearch<CR>

" Moving lines up and down in code
inoremap <A-j> <cmd>m.+1<CR>==gi
inoremap <A-k> <cmd>m.-2<CR>==gi
nnoremap <A-j> <cmd>m.+1<CR>==
nnoremap <A-k> <cmd>m.-2<CR>==
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv

" Missing previous- and next- commands
noremap ]b <cmd>bnext<CR>
noremap [b <cmd>bprevious<CR>
noremap ]t <cmd>tabnext<CR>
noremap [t <cmd>tabprevious<CR>

" }}}
" Commands {{{

command! W :w
command! WA :wa
command! WQ :wq
command! WQA :wqa
command! WQa :wqa
command! Wa :w
command! Wq :wq
command! Wqa :wqa

" }}}
" Colors {{{

silent! colorscheme gruvbox

" }}}
