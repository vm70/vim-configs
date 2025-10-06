---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/stylua", "--lsp" },
	filetypes = { "lua" },
	root_markers = { ".git", "stylua.toml" },
}
