vim.fn["minpac#add"]("quarto-dev/quarto-nvim")
vim.fn["minpac#add"]("jmbuhr/otter.nvim")

require("quarto").setup({
	lspFeatures = {
		enabled = true,
		chunks = "curly",
		languages = { "r", "python", "julia", "bash", "html" },
		diagnostics = {
			enabled = true,
			triggers = { "BufWritePost" },
		},
		completion = {
			enabled = false,
		},
	},
	codeRunner = {
		enabled = true,
		default_method = "slime",
	},
})
