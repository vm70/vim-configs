local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Keymaps {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape Terminal
vim.keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>", { desc = "Escape Terminal Mode" })

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Stop highlight search" })

-- Commenting with Ctrl-/
vim.keymap.set("n", "<C-_>", "<C-v>gc<CR>k", { desc = "Toggle comment" })
vim.keymap.set("v", "<C-_>", "gc<CR>k", { desc = "Toggle comment" })

-- File tree
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle %:h<CR>", { desc = "Toggle file tree, open at file's parent" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- LSP Commands
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh Codelens" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format Buffer" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist, { desc = "View Diagnostics in Quickfix List" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

-- CTRL-P for Commands
vim.keymap.set("n", "<C-P>", "<cmd>FzfLua commands<CR>")

-- Vim-Slime / Vim-Slime-Cells
vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Send cell" })
vim.keymap.set("n", "<leader>sj", "<Plug>SlimeCellsNext", { desc = "Go to next cell" })
vim.keymap.set("n", "<leader>sk", "<Plug>SlimeCellsPrev", { desc = "Go to next cell" })

-- }}}
-- Moving Visual Regions {{{

later(require("mini.move").setup)

-- }}}
-- Bracketed {{{

later(require("mini.bracketed").setup)

-- }}}
-- Selecting Around / Inside {{{

later(function()
	local ai = require("mini.ai")
	ai.setup({
		custom_textobjects = {
			B = require("mini.extra").gen_ai_spec.buffer(),
			F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		},
		search_method = "cover",
	})
end)

-- }}}
-- Surround {{{

later(require("mini.surround").setup)

-- }}}
-- Clue {{{

later(function()
	local MiniClue = require("mini.clue")
	MiniClue.setup({
		-- Define which clues to show. By default shows only clues for custom mappings
		-- (uses `desc` field from the mapping; takes precedence over custom clue).
		clues = {
			MiniClue.gen_clues.builtin_completion(),
			MiniClue.gen_clues.g(),
			MiniClue.gen_clues.marks(),
			MiniClue.gen_clues.registers(),
			MiniClue.gen_clues.square_brackets(),
			MiniClue.gen_clues.windows({ submode_resize = true }),
			MiniClue.gen_clues.z(),
		},
		-- Explicitly opt-in for set of common keys to trigger clue window
		triggers = {
			{ mode = { "n", "x" }, keys = "<Leader>" }, -- Leader triggers
			{ mode = { "n", "x" }, keys = "[" }, -- mini.bracketed
			{ mode = { "n", "x" }, keys = "]" },
			{ mode = "i", keys = "<C-x>" }, -- Built-in completion
			{ mode = { "n", "x" }, keys = "g" }, -- `g` key
			{ mode = { "n", "x" }, keys = "'" }, -- Marks
			{ mode = { "n", "x" }, keys = "`" },
			{ mode = { "n", "x" }, keys = '"' }, -- Registers
			{ mode = { "i", "c" }, keys = "<C-r>" },
			{ mode = "n", keys = "<C-w>" }, -- Window commands
			{ mode = { "n", "x" }, keys = "s" }, -- `s` key (mini.surround, etc.)
			{ mode = { "n", "x" }, keys = "z" }, -- `z` key
		},
	})
end)

-- }}}
