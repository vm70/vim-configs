---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME") .. "/.npm/bin/vim-language-server", "--stdio" },
	filetypes = { "vim" },
	root_markers = { "vimrc", "init.vim" },
}
