vim.g.coq_settings = { auto_start = "shut-up" }

local servers = {
	golangci_lint_ls = {},
	gopls = {},
	lua_ls = {},
	marksman = { filetypes = { "markdown", "markdown.mdx", "markdown.pandoc", "quarto" } },
	pylsp = {},
	ruff_lsp = {},
	taplo = {},
	vimls = {},
	ltex = {
		settings = {
			ltex = {
				language = "en-US",
				disabledRules = {
					["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
				},
			},
		},
	},
	efm = {
		init_options = { documentFormatting = true },
		settings = {},
		filetypes = { "vim", "markdown", "lua", "quarto" },
	},
}

local default_setup = function(server)
	require("lspconfig")[server].setup(require("coq").lsp_ensure_capabilities(servers[server]))
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = { default_setup },
})
