vim.cmd("call minpac#add('neovim/nvim-lspconfig')")

require("lspconfig").golangci_lint_ls.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").lua_ls.setup({})
require("lspconfig").marksman.setup({ filetypes = { "markdown", "markdown.mdx", "markdown.pandoc", "quarto" } })
require("lspconfig").pylsp.setup({})
require("lspconfig").ruff_lsp.setup({})
require("lspconfig").taplo.setup({})
require("lspconfig").vimls.setup({})

require("lspconfig").ltex.setup({
	settings = {
		ltex = {
			disabledRules = {
				["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
			},
		},
	},
})

vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>cf", require("conform").format)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
