---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/efm-langserver" },
	filetypes = {
		"css",
		"html",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"markdown.pandoc",
		"pandoc",
		"qmd",
		"quarto",
		"scss",
		"vim",
		"yaml",
	},
	root_markers = { ".git", "selene.toml", "vimrc", "init.vim" },
}
