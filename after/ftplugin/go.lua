-- Tabs, 2 characters long
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.lsp.enable("gopls")

-- Installation for `golangci-lint-langserver`:
--
-- ```bash
-- go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
-- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
-- ```
vim.lsp.enable("golangci_lint_ls")
