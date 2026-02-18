-- Global Variables {{{

vim.g.filetype_v = "verilog"
vim.g.mapleader = " "

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
vim.opt.completeopt = "menuone,noselect,popup"
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
vim.opt.diffopt = "internal,filler,closeoff,vertical"

-- }}}
-- Bootstrap `mini.nvim` & MiniDeps {{{

-- Clone `mini.nvim` manually in a way that it gets managed by `mini.deps`
local path_package = vim.fn.stdpath("config")
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up `mini.deps`
MiniDeps = require("mini.deps")
MiniDeps.setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Set up `mini.extra` (since other plugins are dependent on it)
later(require("mini.extra").setup)

-- }}}
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

-- Missing previous- and next- keys
later(require("mini.bracketed").setup)
-- Moving lines up and down in code
later(require("mini.move").setup)

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
-- Commands {{{

later(function()
	require("mini.trailspace").setup()
	vim.api.nvim_create_user_command("TrimWhitespace", require("mini.trailspace").trim, { desc = "Trim Whitespace" })
end)

-- }}}
-- Autocommands {{{

-- Disable spelling on terminal windows
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nospell", desc = "Disable spelling on terminal windows" })

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
-- `mini.deps` Now {{{

-- Icons
now(function()
	require("mini.icons").setup({
		filetype = {
			fugitive = { glyph = "󰊢", hl = "MiniIconsOrange" },
			mermaid = { glyph = "󱁉", hl = "MiniIconsCyan" },
			plantuml = { glyph = "", hl = "MiniIconsGrey" },
		},
	})
	later(require("mini.icons").mock_nvim_web_devicons)
	later(require("mini.icons").tweak_lsp_kind)
end)

-- Tab Line
now(require("mini.tabline").setup)

-- Status Line
now(require("mini.statusline").setup)

-- LSP & EFM Configuration
now(function()
	add({ source = "neovim/nvim-lspconfig" })
	add({ source = "creativenull/efmls-configs-nvim" })
end)

-- Color scheme
now(function()
	add({ source = "ellisonleao/gruvbox.nvim" })
	vim.cmd.colorscheme("gruvbox")
end)

-- Autocompletion
now(function()
	require("config-mini-completion")
end)

-- Syntax Plugins
now(function()
	-- PlantUML
	add({ source = "aklt/plantuml-syntax" })
	-- (Better) Pandoc
	add({ source = "vim-pandoc/vim-pandoc" })
	add({ source = "vim-pandoc/vim-pandoc-syntax" })
	-- R Markdown
	add({ source = "vim-pandoc/vim-rmarkdown" })
end)

if vim.fn.executable("tree-sitter") == 1 then
	-- Treesitter
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
		-- Quarto (for Neovim), LSP integration, relies on treesitter
		add({
			source = "quarto-dev/quarto-nvim",
			depends = { "jmbuhr/otter.nvim", "nvim-treesitter/nvim-treesitter", "jpalardy/vim-slime" },
		})
		require("config-treesitter")
	end)
else
	-- Quarto (for Vim), provides better syntax highlighting
	now(function()
		add({ source = "quarto-dev/quarto-vim" })
	end)
end

-- Jupyter / REPL
now(function()
	vim.g.slime_target = "neovim"
	vim.g.slime_no_mappings = true
	vim.g.slime_cell_delimiter = "^# %%.*$"
	vim.g.slime_python_ipython = (vim.fn.executable("ipython") == 1) or (vim.fn.executable("ipython3") == 1)
	add({ source = "jpalardy/vim-slime" })
	vim.g.slime_input_pid = false
	vim.g.slime_suggest_default = true
	vim.g.slime_menu_config = false
	vim.g.slime_neovim_ignore_unlisted = false

	vim.g.slime_cells_no_highlight = 1
	add({ source = "Klafyvel/vim-slime-cells", depends = { "jpalardy/vim-slime" } })
end)

-- }}}
-- `mini.deps` Later {{{

-- Surround
later(require("mini.surround").setup)

-- File Tree
later(function()
	add({ source = "nvim-tree/nvim-tree.lua" })
	require("config-nvim-tree")
end)

-- Fuzzy Finding
later(function()
	add({ source = "ibhagwan/fzf-lua" })
	require("fzf-lua").setup({ "fzf-vim" })
end)

-- Sleuth
later(function()
	add({ source = "tpope/vim-sleuth" })
end)

-- Git Client & Integration
later(function()
	require("mini.git").setup()
	add({ source = "tpope/vim-fugitive" })
	require("mini.diff").setup({ view = { style = "sign" } })
end)

-- Snippets
later(function()
	add({ source = "rafamadriz/friendly-snippets" })
	require("config-mini-snippets")
end)

-- Llama
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

-- Clue
later(function()
	require("config-mini-clue")
end)

later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = require("mini.extra").gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			-- Highlight a fixed set of common words. Will be highlighted in any place,
			-- not like "only in comments".
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
			jupyter = { pattern = "# %%%%", group = "MiniHipatternsNote" },
			-- Highlight hex color string (#aabbcc) with that color as a background
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function()
	add({ source = "hedyhli/outline.nvim" })
	require("outline").setup({
		providers = {
			markdown = {
				filetypes = { "quarto", "pandoc", "markdown", "rmarkdown" },
			},
		},
		symbols = {
			icon_fetcher = "lspkind",
		},
	})
end)

-- }}}
-- Multi-Language LSP Servers {{{

later(function()
	vim.lsp.enable({ "efm", "ltex_plus" })
end)

-- }}}
