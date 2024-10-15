return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree" },
	},
	opts = {
		filesystem = {
			hijack_netrw_behavior = "open_current",
		},
	},
}
