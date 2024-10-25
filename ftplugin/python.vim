let b:slime_cell_delimiter = '# %%'
let b:slime_python_ipython = 1

setlocal colorcolumn=79
setlocal textwidth=79

if executable('black')
  setlocal equalprg=black\ --quiet\ -
  setlocal formatprg=black\ --quiet\ -
endif
