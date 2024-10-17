return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown", "quarto", "markdown.pandoc" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
