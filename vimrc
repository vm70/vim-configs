set encoding=utf8
scriptencoding utf8

" Global Variables {{{

" Vim Global Variables
let mapleader = ' '
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4

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
set showtabline=2

" Editing
set autoindent
set autoread
set foldlevelstart=6
set foldmethod=marker
set incsearch
set linebreak
set mouse=a
set spell
set spelllang=en_us
set listchars=tab:>\\x20,trail:-,nbsp:+
set spelloptions=camel

" Window Splitting
set splitbelow
set splitright

filetype plugin on

" }}}
" Keymaps {{{

" Missing prev- and next- commands
nmap [b :bprevious<CR>
nmap ]b :bNext<CR>
nmap [t :tabprevious<CR>
nmap ]t :tabnext<CR>

" Moving lines up and down in code
inoremap <A-j> <Esc>:m.+1<CR>==gi
inoremap <A-k> <Esc>:m.-2<CR>==gi
nnoremap <A-j> :m.+1<CR>==
nnoremap <A-k> :m.-2<CR>==
vnoremap <A-j> :m'>+1<CR>gv=gv
vnoremap <A-k> :m'<-2<CR>gv=gv

" Toggle File Tree
nnoremap <leader>e :Lexplore 20<CR>

" Remove hlsearch by pressing escape twice
nnoremap <Esc><Esc> :nohlsearch<CR>

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc :JupyterSendCell<CR>


" }}}
" Commands {{{

command! Vimrc :edit $MYVIMRC
command! MakeTags !rg --files | ctags -R -L -'

" }}}
" Colors {{{

silent! colorscheme desert

" }}}
