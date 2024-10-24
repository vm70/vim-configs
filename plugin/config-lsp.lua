vim.fn["minpac#add"]("ms-jpq/coq.artifacts", { branch = "artifacts" })
vim.fn["minpac#add"]("ms-jpq/coq.thirdparty", { branch = "3p" })
vim.fn["minpac#add"]("ms-jpq/coq_nvim", { branch = "coq", ["do"] = "packloadall! | COQdeps" })
vim.fn["minpac#add"]("neovim/nvim-lspconfig")
vim.fn["minpac#add"]("williamboman/mason-lspconfig.nvim")
vim.fn["minpac#add"]("williamboman/mason.nvim")

vim.g.coq_settings = { auto_start = "shut-up" }

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
	efm = { filetypes = { "vim", "markdown", "lua" } },
}

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = { default_setup },
})
