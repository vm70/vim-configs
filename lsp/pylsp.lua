---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/pylsp" },
	-- Don't forget to install the pylsp dependencies & extensions!
	-- https://github.com/python-lsp/python-lsp-server
	filetypes = { "python" },
	root_markers = { "setup.py", "pyproject.toml" },
}
