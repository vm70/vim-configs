---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.sum" },
}
