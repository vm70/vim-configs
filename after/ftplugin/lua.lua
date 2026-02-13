-- Tabs, 2 characters long
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

-- LSP
vim.lsp.enable({"lua_ls", "stylua" })
