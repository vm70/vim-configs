---@type vim.lsp.Config
return {
	init_options = {
		provideFormatter = (not vim.fn.executable("stylua")),
	},
	cmd = {
		"lua-language-server",
		"--logpath=$HOME/.cache/lua-language-server/log",
		"--metapath=$HOME/.cache/lua-language-server/meta",
	},
}
