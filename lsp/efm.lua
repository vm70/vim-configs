---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/efm-langserver" },
	filetypes = { "lua", "vim", "markdown", "markdown.pandoc", "pandoc" },
	root_markers = { ".git", "selene.toml", "vimrc", "init.vim" },
}
