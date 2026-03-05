---@type vim.lsp.Config
return {
	filetypes = {
		"bib",
		"context",
		"gitcommit",
		"html",
		"mail",
		"markdown",
		"markdown.pandoc",
		"mdx",
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
