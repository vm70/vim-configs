return {
	"junegunn/fzf.vim",
	dependencies = { "junegunn/fzf", build = ":call fzf#install()" },
	config = function()
		vim.g.fzf_vim = {}
		vim.g.fzf_vim.tags_command = "!rg --files | ctags -R -L"
	end,
}
