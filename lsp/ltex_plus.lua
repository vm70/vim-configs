---@type vim.lsp.Config
return {
	filetypes = {
		"bib",
		"context",
		"gitcommit",
		"html",
		"markdown",
		"org",
		"pandoc",
		"plaintex",
		"quarto",
		"mail",
		"mdx",
		"rmd",
		"rnoweb",
		"rst",
		"tex",
		"text",
		"typst",
		"xhtml",
		"markdown.pandoc",
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
