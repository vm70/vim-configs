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
