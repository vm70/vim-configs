-- Bootstrap Pckr {{{

local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"
	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/lewis6991/pckr.nvim",
			pckr_path,
		})
	end
	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

-- }}}
-- Instantiate & Configure Plugins {{{

local cmd = require("pckr.loader.cmd")
-- local keys = require("pckr.loader.keys")

require("pckr").add({
	{ -- Auto & injected code block formatting
		"stevearc/conform.nvim",
		config = "plugins.config-conform",
	},
	{ -- Fuzzy finding
		"junegunn/fzf.vim",
		requires = {
			"junegunn/fzf",
			run = ":call fzf#install()",
		},
		config = "plugins.config-fzf",
	},
	{ -- Git configuration plugins
		"tpope/vim-fugitive",
		requires = {
			"rbong/vim-flog",
			"airblade/vim-gitgutter",
			"tpope/vim-rhubarb",
		},
		config = "plugins.config-git",
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
	{ -- Status & tab lines
		"nvim-lualine/lualine.nvim",
		config = "plugins.config-lualine",
	},
	{ -- Markdown preview
		"iamcco/markdown-preview.nvim",
		cond = cmd("MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"),
		run = ":call mkdp#util#install()",
		config = "plugins.config-mkdp",
	},
	{ -- File tree
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = "plugins.config-neo-tree",
	},
	{ -- Treesitter (syntax highlighting and other useful features)
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = "plugins.config-nvim-treesitter",
	},
	{ -- Quarto
		"quarto-dev/quarto-nvim",
		requires = {
			"jmbuhr/otter.nvim",
			"neovim/nvim-lspconfig",
		},
		config = "plugins.config-quarto",
	},
	{ -- Slime (for REPL interactions)
		"jpalardy/vim-slime",
		config = "plugins.config-slime",
	},
	-- Plugins without configurations
	{ "ellisonleao/gruvbox.nvim" },
	{ "tpope/vim-surround" },
})

-- }}}
