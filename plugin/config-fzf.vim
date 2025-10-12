vim9script

nmap <C-S-P> <cmd>Commands<CR> | # FZF: Pull up Commands
nmap <C-S-F> <cmd>Rg<CR> | # FZF: Find across files

g:fzf_vim = {'tags_command': '!rg --files | ctags -R -L'}
