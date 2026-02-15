vim.opt_local.colorcolumn = "88"

-- Slime
vim.b.slime_cell_delimiter = "^# %%.*$"

-- LSP
vim.lsp.enable({ "pylsp", "ruff" })
