set encoding=utf8
scriptencoding utf8

" Global Variables {{{

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
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
set listchars=tab:>\ ,trail:·,nbsp:+
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

" Nerd Fonts
call minpac#add('lambdalisue/vim-glyph-palette')
call minpac#add('lambdalisue/vim-nerdfont')
" Status Line
call minpac#add('Freed-Wu/airline-renderer-nerdfont.vim', {'name': 'vim-airline-nerdfont'})
call minpac#add('vim-airline/vim-airline')
" Colorscheme
call minpac#add('gruvbox-community/gruvbox')
" Fuzzy Finding
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/fzf', {'do': 'packloadall! | call fzf#install()'})
" Editing
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-sleuth')
" Git integration
call minpac#add('tpope/vim-fugitive')
call minpac#add('rbong/vim-flog')
call minpac#add('airblade/vim-gitgutter')
" Jupyter/REPL
call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
" File Tree
call minpac#add('lambdalisue/vim-fern')
call minpac#add('lambdalisue/vim-fern-git-status')
call minpac#add('lambdalisue/vim-fern-hijack')
call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')

" Use built-in comment package if available
if !has('comment-install')
  call minpac#add('tpope/vim-commentary')
else
  packadd! comment
endif

if executable('npm')
  " Markdown Preview
  call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
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
noremap ]b <cmd>bNext<CR>
noremap [b <cmd>bprevious<CR>
noremap ]t <cmd>tabNext<CR>
noremap [t <cmd>tabprevious<CR>

" }}}
" Commands {{{

" Edit Vim RC file
command! Vimrc :cd ~/.vim | edit $MYVIMRC

" Quarto Commands
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

silent! colorscheme gruvbox

" }}}
