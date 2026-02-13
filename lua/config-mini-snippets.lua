-- Define language patterns to work better with 'friendly-snippets'
local latex_patterns = { "latex/**/*.json", "**/latex.json" }
local lang_patterns = {
	tex = latex_patterns,
	plaintex = latex_patterns,
	-- Recognize special injected language of markdown tree-sitter parser
	markdown_inline = { "markdown.json" },
}

local snippets = require("mini.snippets")
local config_path = vim.fn.stdpath("config")
snippets.setup({
	snippets = {
		-- Always load 'snippets/global.json' from config directory
		snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),
		-- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
		snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
	},
	expand = {
		insert = function(snippet, _)
			vim.snippet.expand(snippet.body)
		end,
	},
})

-- By default snippets available at cursor are not shown as candidates in
-- 'mini.completion' menu. This requires a dedicated in-process LSP server
-- that will provide them. To have that, uncomment next line (use `gcc`).
snippets.start_lsp_server()
