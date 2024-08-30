vim.cmd("call minpac#add('nvim-lualine/lualine.nvim')")

require("lualine").setup({
	extensions = { "neo-tree" },
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
})
