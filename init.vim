set encoding=utf8
scriptencoding utf8

" Global Variables {{{

" Vim Global Variables
let g:filetype_md = 'markdown.pandoc'
let g:markdown_folding = 1
let mapleader = ' '

" Plugin Global Variables
let g:coq_settings = {'auto_start': 'shut-up'}
let g:fzf_vim = {}
let g:fzf_vim.tags_command = '!rg --files | ctags -R -L -'
let g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']
let g:slime_target = has('nvim') ? 'neovim' : 'vimterminal'

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
" User Interface
call minpac#add('nvim-neo-tree/neo-tree.nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-tree/nvim-web-devicons')
call minpac#add('MunifTanjim/nui.nvim')
call minpac#add('nvim-lualine/lualine.nvim')
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
" Markdown Preview
call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})

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

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" }}}
" Keymaps {{{

" Missing prev- and next- commands
nmap [b :bprevious<CR>
nmap ]b :bNext<CR>
nmap [h :GitGutterPrevHunk<CR>
nmap ]h :GitGutterNextHunk<CR>
nmap [t :tabprevious<CR>
nmap ]t :tabnext<CR>

" Moving lines up and down in code
inoremap <A-j> <cmd>m.+1<CR>==gi
inoremap <A-k> <cmd>m.-2<CR>==gi
nnoremap <A-j> <cmd>m.+1<CR>==
nnoremap <A-k> <cmd>m.-2<CR>==
vnoremap <A-j> <cmd>m'>+1<CR>gv=gv
vnoremap <A-k> <cmd>m'<-2<CR>gv=gv

" Commenting with Ctrl-/
vmap <C-_> gc<CR>k
nmap <C-_> <C-v>gc<CR>k

" LSP / Linting / Formatting
nnoremap <leader>cC <cmd>lua vim.lsp.codelens.refresh()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cc <cmd>lua vim.lsp.codelens.run()<CR>
nnoremap <leader>cf <cmd>lua require("conform").format()<CR>
nnoremap <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>xx <cmd>lua vim.diagnostic.setqflist()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gI <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gy <cmd>lua vim.lsp.buf.type_definition()<CR>

" Toggle File Tree
nnoremap <leader>e <cmd>Neotree toggle<CR>

" Remove hlsearch by pressing escape twice
nnoremap <Esc><Esc> <cmd>nohlsearch<CR>

" Make exiting the terminal easier (Neovim only)
tnoremap <Esc> <C-\><C-n>

" Send Code Cell
nnoremap <leader>sc <Plug>SlimeSendCell
nnoremap <leader>jc <cmd>JupyterSendCell<CR>

" }}}
" Commands {{{

command! Vimrc :cd ~/.vim | edit $MYVIMRC
command! QuartoPreview :terminal quarto preview
command! QuartoRender :terminal quarto render

" }}}
" Colors {{{

silent! colorscheme gruvbox

" }}}
