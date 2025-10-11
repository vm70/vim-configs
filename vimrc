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
  " Commenting (if missing builtin comment package)
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  if !has('patch-9.1.375')
    call minpac#add('tpope/vim-commentary', {'name': 'comment'})
  end
  " Language Server Protocol
  call minpac#add('yegappan/lsp', {'type': 'opt'})
  if has('python3')
    call minpac#add('SirVer/ultisnips', {'type': 'opt'})
    call minpac#add('honza/vim-snippets', {'type': 'opt'})
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
  " Jupyter/REPL
  call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
  " Colorscheme
  call minpac#add('kratuvid/vim9-gruvbox')
  " Editing
  call minpac#add('tpope/vim-sleuth')
  call minpac#add('tpope/vim-surround')
  " Markdown Preview
  if executable('npm')
    call minpac#add('iamcco/markdown-preview.nvim', {'type': 'opt', 'do': 'packadd! markdown-preview.nvim | call mkdp#util#install()'})
  endif
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

vmap <C-_> gc<CR>k | # Commenting with CTRL-/
nmap <C-_> <C-v>gc<CR>k | # Commenting with CTRL-/

inoremap <A-j> <cmd>m.+1<CR>==gi | # Move lines up and down in code
inoremap <A-k> <cmd>m.-2<CR>==gi | # Move lines up and down in code
nnoremap <A-j> <cmd>m.+1<CR>== | # Move lines up and down in code
nnoremap <A-k> <cmd>m.-2<CR>== | # Move lines up and down in code
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv | # Move lines up and down in code
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv | # Move lines up and down in code

nnoremap <Esc><Esc> <cmd>nohlsearch<CR> | # Stop highlight search

noremap [b <cmd>bprevious<CR> | # Previous buffer
noremap [t <cmd>tabprevious<CR> | # Previous tab
noremap ]b <cmd>bnext<CR> | # Next buffer
noremap ]t <cmd>tabnext<CR> | # Next tab

# }}}
# Commands {{{

command! TrimWhitespace :%s/\s\+$//e | :nohlsearch

# }}}
