local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Treesitter (& fallback plugins) {{{

if vim.g.enable_treesitter then
	now(function()
		add({
			source = "nvim-treesitter/nvim-treesitter",
			hooks = {
				post_checkout = function()
					vim.cmd("TSUpdate")
				end,
			},
		})
		add({
			source = "nvim-treesitter/nvim-treesitter-textobjects",
			checkout = "main",
		})
		-- Quarto (for Neovim), LSP integration, relies on Treesitter
		add({
			source = "quarto-dev/quarto-nvim",
			depends = { "jmbuhr/otter.nvim", "nvim-treesitter/nvim-treesitter", "jpalardy/vim-slime" },
		})
		-- Define languages which will have parsers installed and auto-enabled
		local languages = {
			"c", -- default
			"html",
			"julia",
			"latex",
			"lua", -- default
			"markdown", -- default
			"markdown_inline", -- default
			"mermaid",
			"python",
			"query", -- default
			"vim", -- default
			"vimdoc", -- default
			"yaml",
		}
		-- Define file types that have no corresponding Treesitter parser / language
		local filetypes = {
			"quarto",
		}
		-- Auto-install parsers
		local isnt_installed = function(lang)
			return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
		end
		local to_install = vim.tbl_filter(isnt_installed, languages)
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end
		-- Append file types corresponding to each language to the file types table
		for _, lang in ipairs(languages) do
			for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
				table.insert(filetypes, ft)
			end
		end
		-- Enable tree-sitter after opening a file for a target language / file type
		vim.api.nvim_create_autocmd("Filetype", {
			pattern = filetypes,
			desc = "Start tree-sitter",
			callback = function(ev)
				vim.treesitter.start(ev.buf)
			end,
		})
		-- Set up quarto-nvim when opening Quarto files
		vim.api.nvim_create_autocmd("Filetype", {
			pattern = { "quarto" },
			desc = "Set up quarto-nvim",
			callback = function(_)
				require("quarto").setup()
			end,
		})
	end)
end

-- }}}
