---@type vim.lsp.Config
return {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "**/.luarc.json" },
					url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
				},
			},
		},
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = (not vim.fn.executable("prettier"))
		client.server_capabilities.documentRangeFormattingProvider = (not vim.fn.executable("prettier"))
	end,
}
