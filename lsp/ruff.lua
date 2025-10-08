---@type vim.lsp.Config
return {
	cmd = { vim.fn.expand("$HOME") .. "/.local/bin/ruff", "server" },
	filetypes = { "python" },
	root_markers = { "setup.py", "pyproject.toml" },
}
