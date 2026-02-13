vim.b.slime_cell_delimiter = "# %%"
vim.b.slime_python_ipython = 0

vim.opt_local.colorcolumn = "88"

-- LSP
vim.lsp.enable({"pylsp", "ruff"})
