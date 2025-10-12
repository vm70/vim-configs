local mini_completion = require("mini.completion")
local mini_snippets = require("mini.snippets")

mini_completion.setup()
mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_lang(),
	},
	expand = {
		insert = function(snippet, _)
			vim.snippet.expand(snippet.body)
		end,
	},
})
mini_snippets.start_lsp_server()
vim.lsp.config("*", { capabilities = mini_completion.get_lsp_capabilities()})
