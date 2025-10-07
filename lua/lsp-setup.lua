-- Setup all LSP servers with a valid config
local lsp_config_glob = vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*")
local lsp_config_list = vim.fn.split(lsp_config_glob, "\n")
for _, lsp_config_file in ipairs(lsp_config_list) do
	if string.sub(lsp_config_file, -4) == ".lua" then
		local lsp_name = vim.fn.fnamemodify(lsp_config_file, ":t:r")
		vim.lsp.enable(lsp_name)
	end
end
