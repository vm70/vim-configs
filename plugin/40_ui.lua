local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Tab Line {{{

now(function()
	require("mini.tabline").setup({ show_icons = true, format = nil, tabpage_section = "right" })
end)

-- }}}
-- Status Line {{{

now(require("mini.statusline").setup)

-- }}}
-- Color Scheme {{{

now(function()
	add({ source = "ellisonleao/gruvbox.nvim" })
	vim.cmd.colorscheme("gruvbox")
end)

-- }}}
-- File Tree {{{

now(function()
	add({ source = "nvim-tree/nvim-tree.lua", checkout = "v1.16.0" })
	local function my_on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- default mappings
		api.config.mappings.default_on_attach(bufnr)

		-- on_attach
		vim.keymap.set("n", "N", api.fs.create, opts("Create File Or Directory"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	end

	require("nvim-tree").setup({
		on_attach = my_on_attach,
		diagnostics = { enable = true },
		renderer = {
			icons = {
				git_placement = "right_align",
			},
		},
	})
end)

-- }}}
-- Highlight Patterns {{{

later(function()
	local MiniHipatterns = require("mini.hipatterns")
	local hi_words = require("mini.extra").gen_highlighter.words
	MiniHipatterns.setup({
		highlighters = {
			-- Highlight a fixed set of common words. Will be highlighted in any place,
			-- not like "only in comments".
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
			jupyter = { pattern = "# %%%%", group = "MiniHipatternsNote" },
			-- Highlight hex color string (#aabbcc) with that color as a background
			hex_color = MiniHipatterns.gen_highlighter.hex_color(),
		},
	})
end)

-- }}}
