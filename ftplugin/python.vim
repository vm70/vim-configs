let b:slime_cell_delimiter = '# %%'
let b:slime_python_ipython = 1

setlocal colorcolumn=88
setlocal textwidth=88

if executable('black')
  setlocal equalprg=black\ --quiet\ -
  setlocal formatprg=black\ --quiet\ -
endif
