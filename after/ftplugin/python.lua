vim.opt_local.colorcolumn = "88"

vim.b.slime_cell_delimiter = "^# %%.*$"
vim.b.slime_python_ipython = (vim.fn.executable("ipython") == 1) or (vim.fn.executable("ipython3") == 1)

vim.lsp.enable({ "pylsp", "ruff", "pyrefly" })
