set encoding=utf8
scriptencoding utf8
filetype plugin indent on
syntax on

" Package Setup {{{

" Bootstrap Minpac
let config_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(config_dir.'/pack/minpac/opt/minpac'))
  silent execute '!git clone https://github.com/k-takata/minpac.git '.config_dir.'/pack/minpac/opt/minpac'
endif

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " Language Server Protocol
  call minpac#add('yegappan/lsp', {'type': 'opt'})
  call minpac#add('rafamadriz/friendly-snippets')
  call minpac#add('hrsh7th/vim-vsnip')
  call minpac#add('hrsh7th/vim-vsnip-integ')
  " Nerd Fonts
  call minpac#add('lambdalisue/vim-glyph-palette')
  call minpac#add('lambdalisue/vim-nerdfont')
  " File Tree
  call minpac#add('lambdalisue/vim-fern')
  call minpac#add('lambdalisue/vim-fern-git-status')
  call minpac#add('lambdalisue/vim-fern-hijack')
  call minpac#add('lambdalisue/vim-fern-renderer-nerdfont')
  " Git integration
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('airblade/vim-gitgutter')
  " Status Line
  call minpac#add('Freed-Wu/airline-renderer-nerdfont.vim', {'name': 'vim-airline-nerdfont'})
  call minpac#add('vim-airline/vim-airline')
  " Fuzzy-Finding
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/fzf', {'do': 'packloadall! | call fzf#install()'})
  " Commenting (if missing builtin comment package)
  if !has('patch-9.1.375')
    call minpac#add('tpope/vim-commentary', {'name': 'comment'})
  end
  " Surround
  call minpac#add('tpope/vim-surround')
endfunction
packadd! comment

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

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
set signcolumn=yes
set termguicolors
set title

" Editing
set mouse=a
set autoindent
set autoread

" Searching
set hlsearch
set incsearch

" Folding
set foldlevelstart=6
set foldmethod=marker

" Window Splitting
set splitbelow
set splitright

" Tabs
set noexpandtab
set shiftwidth=2
set tabstop=2

" Spellcheck
set spell
set spelllang=en_us
set spelloptions=camel

" Diff Options
set diffopt=internal,filler,closeoff,vertical


" }}}
" Globals {{{

let g:mapleader = ' '

" }}}
" Keymaps {{{

vmap <C-_> gc<CR>k | " Commenting with CTRL-/
nmap <C-_> <C-v>gc<CR>k | " Commenting with CTRL-/

nnoremap <leader>e <cmd>Fern . -toggle -drawer<CR> | " Fern: Toggle file tree, current directory
nnoremap <leader>E <cmd>Fern %:h -toggle -drawer<CR> | " Fern: Toggle file tree, parent directory of current file

inoremap <A-j> <cmd>m.+1<CR>==gi | " Move lines up and down in code
inoremap <A-k> <cmd>m.-2<CR>==gi | " Move lines up and down in code
nnoremap <A-j> <cmd>m.+1<CR>== | " Move lines up and down in code
nnoremap <A-k> <cmd>m.-2<CR>== | " Move lines up and down in code
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv | " Move lines up and down in code
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv | " Move lines up and down in code

nnoremap <Esc><Esc> <cmd>nohlsearch<CR> | " Stop highlight search

noremap [b <cmd>bprevious<CR> | " Previous buffer
noremap [t <cmd>tabprevious<CR> | "Previous tab
noremap ]b <cmd>bnext<CR> | " Next buffer
noremap ]t <cmd>tabnext<CR> | "Next tab

nmap <C-S-P> <cmd>Commands<CR> | " FZF: Pull up Commands
nmap <C-S-F> <cmd>Rg<CR> | " FZF: Fin across files

imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>' | " VSnip: Snippet Jumping
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>' | " VSnip: Snippet Jumping
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>' | " VSnip: Snippet Jumping
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>' | " VSnip: Snippet Jumping

" }}}
" Nerd Fonts {{{

let g:glyph_palette#palette = copy(g:glyph_palette#defaults#palette)
let g:glyph_palette#palette['GlyphPalette1'] += ['']
let g:glyph_palette#palette['GlyphPalette4'] += ['', '󰐗']
let g:glyph_palette#palette['GlyphPalette7'] += ['']
let g:nerdfont#path#basename#customs = {'go.mod':'', 'go.sum': '', 'pyproject.toml': ''}
let g:nerdfont#path#extension#customs = {'yml': '', 'yaml': '', 'go': '', 'qmd':'󰐗', 'rkt': ''}

" Apply glyph-palette to Fern windows
augroup glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END

" }}}
" File Tree {{{

let g:fern#renderer = 'nerdfont'

" Fern customization
function! s:init_fern() abort
  nmap <buffer> <C-d> <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden)
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" }}}
" LSP Setup {{{

let g:vsnip_snippet_dir = expand('~/.vim/snippets')

packadd lsp

call LspOptionsSet(#{
      \ snippetSupport: v:true,
      \ vsnipSupport: v:true,
      \ })

if filereadable('/opt/lua-language-server/bin/lua-language-server')
  call LspAddServer([#{
    \ name: 'lua-language-server',
    \ filetype: 'lua',
    \ path: '/opt/lua-language-server/bin/lua-language-server',
    \ rootSearch: ['.luarc.json', '.luarc.jsonc'],
    \ }])
endif

if filereadable('/usr/bin/pylsp')
  call LspAddServer([#{
    \ name: 'pylsp',
    \ filetype: 'python',
    \ path: 'pylsp',
    \ rootSearch: ['setup.py', 'pyproject.toml'],
    \ }])
endif

if filereadable('/usr/bin/npx')
  call LspAddServer([#{
    \ name: 'vimls',
    \ filetype: 'vim',
    \ path: '/usr/bin/npx',
    \ args: ['-y', 'vim-language-server', '--stdio'],
    \ rootSearch: ['init.vim', 'vimrc'],
    \ }])
endif

if filereadable('/usr/bin/efm-langserver')
  call LspAddServer([#{
    \ name: 'efm-langserver',
    \ filetype: ['vim', 'lua', 'markdown', 'json'],
    \ path: '/usr/bin/efm-langserver',
    \ rootSearch: ['init.vim', 'vimrc', 'stylua.toml', 'selene.toml'],
    \ }])
endif

" }}}
" Colorscheme {{{

colorscheme retrobox

" }}}
" Status Line / Tab Line {{{

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" }}}
" Fuzzy Finding {{{

let g:fzf_vim = {'tags_command': '!rg --files | ctags -R -L'}

" }}}
