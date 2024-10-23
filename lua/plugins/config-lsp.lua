local default_setup = function(server)
	require("lspconfig")[server].setup(require("coq").lsp_ensure_capabilities())
end

local servers = {
	golangci_lint_ls = {},
	gopls = {},
	lua_ls = {},
	marksman = { filetypes = { "markdown", "markdown.mdx", "markdown.pandoc", "quarto" } },
	pylsp = {},
	taplo = {},
	vimls = {},
	ltex = {
		settings = {
			ltex = {
				disabledRules = {
					["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
				},
			},
		},
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"ms-jpq/coq_nvim",
			branch = "coq",
			dependencies = {
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				{ "ms-jpq/coq.thirdparty", branch = "3p" },
			},
			build = ":COQdeps",
			init = function()
				vim.g.coq_settings = { auto_start = "shut-up" }
			end,
		},
		{ "williamboman/mason.nvim", opts = {} },
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = true,
				handlers = { default_setup },
			},
		},
	},
}
