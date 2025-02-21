vim.g.coq_settings = { auto_start = "shut-up" }

local servers = {
	lua_ls = {},
	marksman = { filetypes = { "markdown", "markdown.mdx", "markdown.pandoc", "quarto" } },
	taplo = {},
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
}

if vim.fn.executable("go") == true then
	servers.golangci_lint_ls = {}
	servers.gopls = {}
end

if vim.fn.executable("python") == true then
	servers.pylsp = {}
	servers.ruff_lsp = {}
end

if vim.fn.executable("npm") == true then
	servers.vimls = {}
end

local default_setup = function(server)
	require("lspconfig")[server].setup(require("coq").lsp_ensure_capabilities(servers[server]))
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	handlers = { default_setup },
})
