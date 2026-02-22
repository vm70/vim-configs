local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Keymaps {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape Terminal
vim.keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>", { desc = "Escape terminal mode" })

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Stop highlight search" })

-- File tree
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle %:h<CR>", { desc = "Toggle file tree, open at file's parent" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- LSP keymaps (using global defaults)
vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "Select code action" })
vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "List implementations" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "List all references" })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { desc = "List all symbols in current buffer" })
vim.keymap.set("i", "<C-S>", vim.lsp.buf.signature_help, { desc = "Show signature information" })

-- Alternate LSP Keymaps
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "grL", vim.lsp.codelens.refresh, { desc = "Refresh code lens" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "grl", vim.lsp.codelens.run, { desc = "Run code lens" })
vim.keymap.set("n", "grx", vim.diagnostic.setqflist, { desc = "View diagnostics in quickfix list" })

-- Vim-Slime / Vim-Slime-Cells
vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Send code cell" })
vim.keymap.set("n", "<leader>sC", "<Plug>SlimeCellsSendAndGoToNext", { desc = "Send code cell & go to next" })
vim.keymap.set("n", "<leader>sj", "<Plug>SlimeCellsNext", { desc = "Go to next code cell" })
vim.keymap.set("n", "<leader>sk", "<Plug>SlimeCellsPrev", { desc = "Go to next code cell" })

-- }}}
-- Moving Visual Regions {{{

later(require("mini.move").setup)

-- }}}
-- Bracketed {{{

later(require("mini.bracketed").setup)

-- }}}
-- Selecting Around / Inside {{{

later(function()
	local MiniAi = require("mini.ai")
	MiniAi.setup({
		custom_textobjects = {
			B = require("mini.extra").gen_ai_spec.buffer(),
			F = MiniAi.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
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
