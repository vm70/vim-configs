-- Bootstrap Pckr {{{

local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("config") .. "/pack/pckr/opt/pckr.nvim"
	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/lewis6991/pckr.nvim",
			pckr_path,
		})
	end
	vim.cmd.packadd("pckr.nvim")
	require("pckr").setup({ autoremove = true, package_root = vim.fn.stdpath("config") })
end

bootstrap_pckr()

-- }}}
-- Instantiate & Configure Plugins {{{

require("pckr").add({
	{ -- Gruvbox color scheme
		"ellisonleao/gruvbox.nvim",
		config = "plugins.config-gruvbox",
	},
	{ -- File tree
		"nvim-tree/nvim-tree.lua",
		requires = {
			{ -- Nerd font icons
				"nvim-tree/nvim-web-devicons",
				config = "plugins.config-devicons",
			},
		},
		config = "plugins.config-nvim-tree",
	},
	{ -- Status & tab lines
		"nvim-lualine/lualine.nvim",
		config = "plugins.config-lualine",
	},
	{ -- Fuzzy-finding
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({ "fzf-vim" })
		end,
	},
	{ -- Language server configuration
		"neovim/nvim-lspconfig",
		requires = {
			{ "ms-jpq/coq_nvim", branch = "coq", run = ":COQdeps" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = "plugins.config-lsp",
	},
	{ -- Auto & injected code block formatting
		"stevearc/conform.nvim",
		config = "plugins.config-conform",
	},
	{ -- Diagnostics and quick-fix setup
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	},
	{ -- Git configuration plugins
		"tpope/vim-fugitive",
		requires = {
			"rbong/vim-flog",
			{
				"lewis6991/gitsigns.nvim",
				config = function()
					require("gitsigns").setup({ diff_opts = { vertical = false } })
				end,
			},
		},
	},
	{ -- Edit surrounding characters
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{ -- Auto detect indentation
		"tpope/vim-sleuth",
	},
	{ -- Slime (for REPL interactions)
		"jpalardy/vim-slime",
		config_pre = function()
			vim.g.slime_target = "neovim"
		end,
		config = "plugins.config-slime",
	},
	-- { -- Treesitter (syntax highlighting and other useful features)
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	run = ":TSUpdate",
	-- 	requires = {
	-- 		"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	},
	-- 	config = "plugins.config-nvim-treesitter",
	-- },
	-- { -- Quarto
	-- 	"quarto-dev/quarto-nvim",
	-- 	requires = {
	-- 		"jmbuhr/otter.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- 	config = "plugins.config-quarto",
	-- },
})

-- }}}
