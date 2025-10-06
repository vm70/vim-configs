---@type vim.lsp.Config
return {
	cmd = { '/usr/bin/pylsp' },
	filetypes = { 'python' },
	root_markers = { 'setup.py', 'pyproject.toml' }
}
