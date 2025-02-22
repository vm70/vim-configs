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

if vim.fn.executable("go") == 1 then
	servers.golangci_lint_ls = {}
	servers.gopls = {}
end

if (vim.fn.executable("python") == 1) or (vim.fn.executable("python3") == 1) then
	servers.pylsp = {}
end

if vim.fn.executable("npm") == 1 then
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
