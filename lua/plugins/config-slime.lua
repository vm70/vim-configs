return {
	"jpalardy/vim-slime",
	ft = { "julia", "python" },
	config = function()
		vim.g.slime_target = "neovim"
	end,
	keys = { {
		"<leader>sc",
		"<Plug>SlimeSendCell",
		mode = "n",
	} },
}
