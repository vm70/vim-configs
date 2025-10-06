---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/efm-langserver" },
	filetypes = { "lua", "vim" },
	root_markers = { ".git", "selene.toml", "vimrc", "init.vim" },
}
