vim9script

nmap <C-S-P> <cmd>Commands<CR>
nmap <C-S-F> <cmd>Rg<CR>

g:fzf_vim = {'tags_command': '!rg --files | ctags -R -L'}
