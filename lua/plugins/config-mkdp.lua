return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown", "quarto", "markdown.pandoc" },
	build = function()
		vim.cmd("call mkdp#util#install()")
	end,
}
