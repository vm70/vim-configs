-- Customize post-processing of LSP responses for a better user experience.
-- Don't show 'Text' suggestions (usually noisy) and show snippets last.
local process_items = function(items, base)
	return require("mini.completion").default_process_items(
		items,
		base,
		{ kind_priority = { Text = -1, Snippet = 99 } }
	)
end
require("mini.completion").setup({
	lsp_completion = {
		-- Without this config autocompletion is set up through `:h 'completefunc'`.
		-- Although not needed, setting up through `:h 'omnifunc'` is cleaner
		-- (sets up only when needed) and makes it possible to use `<C-u>`.
		source_func = "omnifunc",
		auto_setup = false,
		process_items = process_items,
	},
})

-- Set 'omnifunc' for LSP completion only when needed.
local on_attach = function(ev)
	vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
end
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = nil,
	callback = on_attach,
	desc = "Set omnifunc",
})

-- Advertise to servers that Neovim now supports certain set of completion and
-- signature features through 'mini.completion'.
vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })
