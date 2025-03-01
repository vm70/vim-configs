augroup mkdp
  autocmd!
  autocmd BufReadPre *.md packadd markdown-preview.nvim
  autocmd BufReadPre *.qmd packadd markdown-preview.nvim
augroup END

let g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']

