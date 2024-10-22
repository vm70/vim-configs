call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/fzf', {'do': 'packloadall! | call fzf#install()'})

let g:fzf_vim = {}
let g:fzf_vim.tags_command = '!rg --files | ctags -R -L'
