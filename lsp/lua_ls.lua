---@type vim.lsp.Config
return {
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = (not vim.fn.executable('stylua'))
		client.server_capabilities.documentRangeFormattingProvider = (not vim.fn.executable('stylua'))
	end,
}
