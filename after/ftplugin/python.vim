vim9script

b:slime_cell_delimiter = '# %%'

if executable("ipython")
  b:slime_python_ipython = 1
else
  b:slime_python_ipython = 0
endif

setlocal colorcolumn=88
