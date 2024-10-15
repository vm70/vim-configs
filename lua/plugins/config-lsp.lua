local default_setup = function(server)
	require("lspconfig")[server].setup({})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "lua_ls" },
				automatic_installation = true,
				handlers = { default_setup },
			},
		},
	},
}
