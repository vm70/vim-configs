vim9script

augroup plantuml-setup
  autocmd!
  autocmd BufReadPre *.pu,*.uml,*.plantuml,*.puml,*.iuml packadd plantuml-syntax
augroup END
