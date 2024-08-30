vim.cmd("call minpac#add('nvim-neo-tree/neo-tree.nvim')")
vim.cmd("call minpac#add('nvim-lua/plenary.nvim')")
vim.cmd("call minpac#add('nvim-tree/nvim-web-devicons')")
vim.cmd("call minpac#add('MunifTanjim/nui.nvim')")

require("neo-tree").setup({
	filesystem = {
		hijack_netrw_behavior = "open_current",
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
