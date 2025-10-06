require('mini.completion').setup({})
local gen_loader = require('mini.snippets').gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_lang(),
	},
	expand = {
		insert = function(snippet, _) vim.snippet.expand(snippet.body) end
	}
})

require("mini.snippets").start_lsp_server()
