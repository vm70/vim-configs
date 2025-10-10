---@type vim.lsp.Config
return {
	cmd = { "/opt/lua-language-server/bin/lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
