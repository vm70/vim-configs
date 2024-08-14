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
