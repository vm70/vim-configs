require("nvim-web-devicons").setup({
	override_by_extension = {
		["qmd"] = {
			icon = "󰐗",
			name = "Quarto",
			color = "#75aadb",
			cterm_color = 75,
		},
	},
})

require("neo-tree").setup({
	filesystem = {
		hijack_netrw_behavior = "open_current",
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
