local default_setup = function(server)
	require("lspconfig")[server].setup({})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"ms-jpq/coq_nvim",
		{ "williamboman/mason.nvim", opts = {} },
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				automatic_installation = true,
				handlers = { default_setup },
			},
		},
	},
}
