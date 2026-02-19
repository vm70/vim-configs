local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Global Variables {{{

vim.g.filetype_md = "pandoc"
vim.g.filetype_v = "verilog"
vim.g.treesitter_enable = true

-- }}}
-- Options {{{

-- Visuals
vim.opt.background = "dark"
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "+" }
vim.opt.number = true
vim.opt.showbreak = "↪ "
vim.opt.termguicolors = true
vim.opt.title = true

-- Editing
vim.opt.autoread = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.foldlevelstart = 6
vim.opt.foldmethod = "marker"
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

-- Window Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Diff options
vim.opt.diffopt = { "internal", "filler", "closeoff", "vertical" }

-- }}}
-- Filetypes {{{

vim.filetype.add({
	extension = {
		pu = "plantuml",
		puml = "plantuml",
		iuml = "plantuml",
	},
})

-- }}}
-- Icons {{{

now(function()
	require("mini.icons").setup({
		filetype = {
			fugitive = { glyph = "󰊢", hl = "MiniIconsOrange" },
			mermaid = { glyph = "󱁉", hl = "MiniIconsCyan" },
			plantuml = { glyph = "", hl = "MiniIconsGrey" },
		},
		extension = {
			md = vim.g.filetype_md,
			v = vim.g.filetype_v,
		},
	})
	now(require("mini.icons").mock_nvim_web_devicons)
	later(require("mini.icons").tweak_lsp_kind)
end)

-- }}}
-- Digraphs {{{

-- See also: https://vimhelp.org/digraph.txt.html#digraph

vim.fn.digraph_setlist({
	-- Alternatives for preexisting digraphs
	{ "Ss", "§" }, -- (original digraph SE) U+00A7 SECTION SIGN
	{ "|^", "↑" }, -- (original digraph -!) U+2191 UPWARDS ARROW
	{ "|v", "↓" }, -- (original digraph -v) U+2193 DOWNWARDS ARROW
	-- New digraphs
	{ ":(", "🙁" }, -- U+1F641 SLIGHTLY FROWNING FACE
	{ ":)", "🙂" }, -- U+1F642 SLIGHTLY SMILING FACE
})

-- }}}
-- Syntax {{{

now(function()
	-- PlantUML
	add({ source = "aklt/plantuml-syntax" })
	-- R Markdown
	add({ source = "vim-pandoc/vim-rmarkdown" })
end)

-- }}}
