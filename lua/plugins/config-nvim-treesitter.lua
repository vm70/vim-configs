require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"python",
		"julia",
		"racket",
		"r",
	},
	auto_install = true,
	highlight = { enable = true, disable = { "markdown", "pandoc", "quarto" } },
})
