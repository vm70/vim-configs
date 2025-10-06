---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/npx", "-y", "vim-language-server", "--stdio" },
	filetypes = { "vim" },
	root_markers = { "vimrc", "init.vim" },
}
