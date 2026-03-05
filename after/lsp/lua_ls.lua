---@type vim.lsp.Config
return {
	cmd = {
		"lua-language-server",
		"--logpath=$HOME/.cache/lua-language-server/log",
		"--metapath=$HOME/.cache/lua-language-server/meta",
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = (not vim.fn.executable("stylua"))
		client.server_capabilities.documentRangeFormattingProvider = (not vim.fn.executable("stylua"))
	end,
}
