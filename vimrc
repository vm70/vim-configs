vim9script
set encoding=utf8
scriptencoding utf8
filetype plugin indent on
syntax on

# Package Setup {{{

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
  call minpac#add('SirVer/ultisnips')
  call minpac#add('honza/vim-snippets')
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
endfunction
packadd! comment

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

# Folding
set foldlevelstart=6
set foldmethod=marker

# Window Splitting
set splitbelow
set splitright

# Spelling options
set spell
set spelllang=en_us

# LSP Options
set formatexpr=lsp#lsp#FormatExpr()
set keywordprg=:LspHover

# }}}
# Globals {{{

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
noremap [t <cmd>tabprevious<CR> | #Previous tab
noremap ]b <cmd>bnext<CR> | # Next buffer
noremap ]t <cmd>tabnext<CR> | #Next tab

nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR> | # Fern: Toggle file tree, current directory
nnoremap <leader>E <cmd>Fern %:h -toggle -drawer<CR> | # Fern: Toggle file tree, parent directory of current file

nmap <C-S-P> <cmd>Commands<CR> | # FZF: Pull up Commands
nmap <C-S-F> <cmd>Rg<CR> | # FZF: Find across files

nnoremap <leader>sc <Plug>SlimeSendCell | # Slime: Send Code Cell

nmap gra <cmd>LspCodeAction<CR>
vmap gra <cmd>LspCodeAction<CR>
nmap gri <cmd>LspGotoImpl<CR>
nmap grn <cmd>LspRename<CR>
nmap grr <cmd>LspShowReferences<CR>
nmap grt <cmd>LspGotoTypeDef<CR>

# }}}
