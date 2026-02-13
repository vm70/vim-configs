vim.opt_local.colorcolumn = "88"

-- Slime
vim.b.slime_cell_delimiter = "^# %%.*$"
if vim.fn.executable("ipython") == 1 then
	vim.g.slime_python_ipython = 1
else
	vim.g.slime_python_ipython = 0
end

-- LSP
vim.lsp.enable({ "pylsp", "ruff" })
