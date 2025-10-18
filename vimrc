vim9script
set encoding=utf8
scriptencoding utf8
filetype plugin indent on
syntax on

# Package Setup {{{

if $MYVIMDIR == ''
  $MYVIMDIR = expand('$HOME/.vim')
endif

if empty(glob('$MYVIMDIR/pack/minpac/opt/minpac'))
  silent execute '!git clone https://github.com/k-takata/minpac.git $MYVIMDIR/pack/minpac/opt/minpac'
endif

function PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " Commenting (if missing builtin comment package)
  if !has('patch-9.1.375')
    call minpac#add('tpope/vim-commentary', {'name': 'comment', 'type': 'opt'})
  endif
  " Nerd Fonts
  call minpac#add('lambdalisue/vim-glyph-palette')
  call minpac#add('lambdalisue/vim-nerdfont')
  " File Tree
  call minpac#add('lambdalisue/vim-fern')
  call minpac#add('lambdalisue/vim-fern-git-status')
  call minpac#add('lambdalisue/vim-fern-hijack')
  call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
  " Git Integration
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('airblade/vim-gitgutter')
  " Status Line
  call minpac#add('Freed-Wu/airline-renderer-nerdfont.vim', {'name': 'vim-airline-nerdfont'})
  call minpac#add('vim-airline/vim-airline')
  " Fuzzy-Finding
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/fzf', {'do': 'packloadall! | call fzf#install()'})
  " Surround
  call minpac#add('tpope/vim-surround')
  " Sleuth
  call minpac#add('tpope/vim-sleuth')
  " Jupyter/REPL
  call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
  " Colorscheme
  call minpac#add('kratuvid/vim9-gruvbox')
  if executable('npm')
    " Markdown Preview
    call minpac#add('iamcco/markdown-preview.nvim', {'type': 'opt', 'do': 'packadd! markdown-preview.nvim | call mkdp#util#install()'})
    " LSP Integration, Snippets, Autocompletion
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
    call minpac#add('rafamadriz/friendly-snippets')
  endif
  " Llama
  call minpac#add('ggml-org/llama.vim', {'type': 'opt'})
  " PlantUML
  call minpac#add('aklt/plantuml-syntax')
endfunction
silent! packadd! comment

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

# }}}
# Options {{{

# Visuals
set background=dark
set cursorline
set fillchars=vert:│,fold:-,eob:~
set list
set listchars=tab:→\ ,trail:·,nbsp:+
set number
set showbreak=↪\ |
set signcolumn=yes
set termguicolors
set title
set wildoptions=pum

# Controls
set mouse=a

# Searching
set hlsearch
set incsearch
set wildmenu

# Folding
set foldlevelstart=6
set foldmethod=marker

# Window Splitting
set splitbelow
set splitright

# Spelling options
set spell
set spelllang=en_us

# }}}
# Globals {{{

g:filetype_md = 'markdown.pandoc'
g:filetype_v = 'verilog'
g:mapleader = ' '

# }}}
# Keymaps {{{

# Commenting with CTRL-/
vmap <C-_> gc<CR>k
nmap <C-_> <C-v>gc<CR>k

# Move lines up and down in code
inoremap <A-j> <cmd>m.+1<CR>==gi
inoremap <A-k> <cmd>m.-2<CR>==gi
nnoremap <A-j> <cmd>m.+1<CR>==
nnoremap <A-k> <cmd>m.-2<CR>==
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv

# Stop highlight search
nnoremap <Esc><Esc> <cmd>nohlsearch<CR>

# Missing previous- and next- commands
noremap [b <cmd>bprevious<CR>
noremap [t <cmd>tabprevious<CR>
noremap ]b <cmd>bnext<CR>
noremap ]t <cmd>tabnext<CR>

# }}}
# Commands {{{

command! TrimWhitespace :%s/\s\+$//e | :nohlsearch
command! UseTabs :set noexpandtab | :set shiftwidth=2 | :set tabstop=2
command! -nargs=1 UseSpaces :set expandtab | :set shiftwidth=<args> | :set tabstop=<args>

# }}}
