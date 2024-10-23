vim.fn["minpac#add"]("nvim-treesitter/nvim-treesitter", { ["do"] = "packloadall! | TSUpdate" })

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = { enable = true, disable = { "markdown", "pandoc", "quarto" } },
})
