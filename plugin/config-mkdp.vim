vim9script

augroup mkdp
  autocmd!
  autocmd BufReadPre *.md,*.qmd packadd markdown-preview.nvim
augroup END

g:mkdp_filetypes = ['markdown', 'quarto', 'markdown.pandoc']
