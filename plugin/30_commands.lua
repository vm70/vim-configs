local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Commands {{{

vim.api.nvim_create_user_command("Keymaps", "FzfLua keymaps", { desc = "Search for keymaps" })
vim.api.nvim_create_user_command("TrimWhitespace", require("mini.trailspace").trim, { desc = "Trim Whitespace" })

-- }}}
-- Autocommands {{{

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nospell", desc = "Disable spelling on terminal windows" })

-- }}}
-- Trailing Spaces {{{

later(require("mini.trailspace").setup)

-- }}}
-- Align {{{

later(function()
	require("mini.align").setup({
		mappings = {
			start = "<leader>La",
			start_with_preview = "<leader>LA",
		},
	})
end)

-- }}}
-- Sleuth {{{

later(function()
	add({ source = "tpope/vim-sleuth" })
end)

-- }}}
-- Git Integration {{{

later(function()
	require("mini.git").setup()
	add({ source = "tpope/vim-fugitive" })
	require("mini.diff").setup({ view = { style = "sign" } })
end)

-- }}}
-- Fuzzy Finding {{{

later(function()
	add({ source = "ibhagwan/fzf-lua" })
	require("fzf-lua").setup({ "fzf-vim" })
end)

-- }}}
-- AI Completion {{{

if vim.fn.executable("llama-server") == 1 then
	later(function()
		vim.g.llama_config = {
			enable_at_startup = false,
			keymap_inst_accept = "<Tab>",
			keymap_inst_cancel = "<Esc>",
			keymap_inst_continue = "<leader>llc",
			keymap_inst_retry = "<leader>llr",
			keymap_inst_trigger = "<leader>lli",
		}
		add({ source = "ggml-org/llama.vim" })
	end)
end

-- }}}
-- Outline {{{

later(function()
	add({ source = "hedyhli/outline.nvim" })
	require("outline").setup({
		providers = {
			markdown = {
				filetypes = { "quarto", "pandoc", "markdown", "rmarkdown" },
			},
		},
		symbols = {
			icon_fetcher = function(kind, _, _)
				local ok, icon = pcall(require("mini.icons").get, "lsp", string.lower(kind))
				if ok then
					return icon
				else
					return nil
				end
			end,
		},
	})
end)

-- }}}
