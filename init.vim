" Global Variables {{{

" Vim Global Variables
let g:filetype_md = 'markdown.pandoc'
let g:markdown_folding = 1
let mapleader = ' '

" Plugin Global Variables
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:coq_settings = { 'auto_start': 'shut-up' }
let g:fzf_vim = {}
let g:fzf_vim.tags_command = '!rg --files | ctags -R -L -'
let g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']

" }}}
" Options {{{

" Visuals
set conceallevel=2
set cursorline
set list
set number
set termguicolors
set title

" Editing
set foldlevelstart=6
set foldmethod=marker
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

augroup MinpacAutoInstall
  autocmd!
  autocmd VimEnter * if len(filter(values(minpac#pluglist), '!isdirectory(v:val["dir"])'))
    \| call minpac#update()
    \| source $MYVIMRC
    \| endif
augroup END

function! PackInit() abort
  " Let Minpac manage itself
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " User Interface
  call minpac#add('nvim-neo-tree/neo-tree.nvim')
  \| call minpac#add('nvim-lua/plenary.nvim')
  \| call minpac#add('nvim-tree/nvim-web-devicons')
  \| call minpac#add('MunifTanjim/nui.nvim')
  call minpac#add('vim-airline/vim-airline')
  " Editing
  call minpac#add('tpope/vim-surround')
  " Treesitter
  call minpac#add('nvim-treesitter/nvim-treesitter', {'do': 'packloadall! | TSUpdate'})
  " REPL / Jupyter call
  call minpac#add('jpalardy/vim-slime', {'type': 'opt'})
  call minpac#add('jupyter-vim/jupyter-vim', {'type': 'opt'})
  " Version Control
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('rbong/vim-flog')
  call minpac#add('airblade/vim-gitgutter')
  " LSP / Linting / Formatting Integration
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('mfussenegger/nvim-lint')
  call minpac#add('stevearc/conform.nvim')
  " Fuzzy Finding
  call minpac#add('junegunn/fzf.vim')
  " Autocompletion
  call minpac#add('ms-jpq/coq_nvim', {'branch': 'coq'})
  call minpac#add('ms-jpq/coq.artifacts', {'branch': 'artifacts'})
  call minpac#add('ms-jpq/coq.thirdparty', {'branch': '3p'})
  " Colors
  call minpac#add('ellisonleao/gruvbox.nvim')
  call minpac#add('vim-airline/vim-airline-themes')
  " Markdown Preview
  call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
endfunction

" Disable some things when opening terminals
augroup term
  autocmd!
  autocmd TermOpen * setlocal nonumber nospell
augroup END

augroup repl
  autocmd!
  autocmd BufReadPre *.py packadd jupyter-vim vim-slime
  autocmd BufReadPre *.jl packadd jupyter-vim vim-slime
augroup END

" Define user commands for updating/cleaning the plugins.
call PackInit()
command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()

" }}}
" Keymaps {{{

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

" LSP / Linting / Formatting
nnoremap <leader>cC :lua vim.lsp.codelens.refresh()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cc :lua vim.lsp.codelens.run()<CR>
nnoremap <leader>cf :lua require("conform").format()<CR>
nnoremap <leader>cr :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>xx :lua vim.diagnostic.setqflist()<CR>
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap gI :lua vim.lsp.buf.implementation()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap gy :lua vim.lsp.buf.type_definition()<CR>

" Toggle File Tree
nnoremap <leader>e :Neotree toggle<CR>

" Remove hlsearch by pressing escape twice
nnoremap <Esc><Esc> :nohlsearch<CR>

" Make exiting the terminal easier (Neovim only)
tnoremap <Esc> <C-\><C-n>

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc :JupyterSendCell<CR>

" }}}
" Commands {{{

command! Vimrc :edit $MYVIMRC
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

colorscheme gruvbox
let g:airline_theme = 'base16_gruvbox_dark_medium'

" }}}
