vim9script
if executable('latexindent')
  set equalprg=latexindent\ -
  set formatprg=latexindent\ -
endif
