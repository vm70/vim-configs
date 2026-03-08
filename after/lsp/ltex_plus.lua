---@type vim.lsp.Config
return {
	filetypes = {
		"bib",
		"context",
		"html",
		"mail",
		"markdown",
		"org",
		"pandoc",
		"plaintex",
		"quarto",
		"rmd",
		"rnoweb",
		"rst",
		"tex",
		"text",
		"typst",
		"xhtml",
		-- "gitcommit",
		-- "markdown.pandoc",
		-- "mdx",
	},
	settings = {
		ltex = {
			language = "en-US",
			disabledRules = {
				["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
			},
		},
	},
}
