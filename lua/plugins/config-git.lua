return {
	{ "tpope/vim-fugitive" },
	{ "rbong/vim-flog" },
	{ "tpope/vim-rhubarb" },
	{
		"lewis6991/gitsigns.nvim",
		keys = {
			{ "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Go to next hunk" },
			{ "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Go to previous hunk" },
		},
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}
