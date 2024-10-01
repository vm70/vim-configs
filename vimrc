set encoding=utf8
scriptencoding utf8

" Global Variables {{{

let g:filetype_md = 'markdown.pandoc'
let g:markdown_folding = 1
let mapleader = ' '

" }}}
" Options {{{

" Visuals
set background=dark
set conceallevel=2
set cursorline
set list
set listchars=tab:>\ ,trail:-,nbsp:+
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
" Editing
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-sleuth')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

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


" }}}
" Commands {{{

command! Vimrc :cd ~/.vim | edit $MYVIMRC
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

colorscheme retrobox

" }}}
