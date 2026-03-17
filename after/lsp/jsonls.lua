---@type vim.lsp.Config
return {
	init_options = {
		provideFormatter = (not vim.fn.executable("prettier")),
	},
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
}
