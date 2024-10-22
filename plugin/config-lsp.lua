vim.fn["minpac#add"]("ms-jpq/coq.nvim")
vim.fn["minpac#add"]("neovim/nvim-lspconfig")
vim.fn["minpac#add"]("williamboman/mason-lspconfig.nvim")
vim.fn["minpac#add"]("williamboman/mason.nvim")

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

local function default_setup(server_name)
	require("lspconfig")[server_name].setup(servers[server_name])
	require("lspconfig")[server_name].setup(require("coq").lsp_ensure_capabilities({}))
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = { default_setup },
})

vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
