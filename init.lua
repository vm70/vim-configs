-- Global Variables {{{

vim.g.filetype_md = "markdown.pandoc"
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
vim.opt.foldlevelstart = 6
vim.opt.completeopt = "menuone,noinsert,popup"
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
-- Keymaps {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-N><C-\\>")

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

-- Commenting with Ctrl-/
vim.keymap.set("n", "<C-_>", "<C-v>gc<CR>k")
vim.keymap.set("v", "<C-_>", "gc<CR>k")

-- Moving lines up and down in code
vim.keymap.set("i", "<A-j>", "<cmd>m.+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<cmd>m.-2<CR>==gi")
vim.keymap.set("n", "<A-j>", "<cmd>m.+1<CR>==")
vim.keymap.set("n", "<A-k>", "<cmd>m.-2<CR>==")
vim.keymap.set("v", "<A-j>", "<cmd>m'>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", "<cmd>m'<-2<CR>gv=gv")

-- File tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Missing previous- and next- keys
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>")
vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>")
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>")

-- LSP Commands
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)

-- CTRL-P for Commands
vim.keymap.set("n", "<C-P>", "<cmd>FzfLua commands<CR>")

-- }}}
-- LSP Setup {{{

require("lsp-setup")

-- }}}
-- Commands {{{

vim.api.nvim_create_user_command("LspFormat", vim.lsp.buf.format, { bang = true })

-- Accidental shift-commands
vim.api.nvim_create_user_command("W", ":w", { bang = true })
vim.api.nvim_create_user_command("WA", ":wa", { bang = true })
vim.api.nvim_create_user_command("WQ", ":wq", { bang = true })
vim.api.nvim_create_user_command("WQA", ":wqa", { bang = true })
vim.api.nvim_create_user_command("WQa", ":wqa", { bang = true })
vim.api.nvim_create_user_command("Wa", ":wa", { bang = true })
vim.api.nvim_create_user_command("Wq", ":wq", { bang = true })
vim.api.nvim_create_user_command("Wqa", ":wqa", { bang = true })

-- Edit Vim RC file
vim.api.nvim_create_user_command("Vimrc", ":edit $MYVIMRC", { bang = true })

-- Quarto Commands
vim.api.nvim_create_user_command("QuartoPreview", ":terminal quarto preview", { bang = true })
vim.api.nvim_create_user_command("QuartoRender", ":terminal quarto render", { bang = true })

-- LSP Commands
vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", { bang = true })

-- }}}
-- Package Setup {{{

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

require("pckr").add({
	-- Icons
	{ "nvim-mini/mini.icons", config = "config-icons" },
	-- File Tree
	{ "nvim-tree/nvim-tree.lua", config = "config-nvim-tree" },
	-- Colorscheme
	{ "ellisonleao/gruvbox.nvim" },
	-- Status Line
	{ "nvim-lualine/lualine.nvim", config = "config-lualine" },
	-- Fuzzy Finding
	{ "ibhagwan/fzf-lua" },
	-- Git Integration
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	-- Completion & Snippets
	{
		"nvim-mini/mini.snippets",
		config = "config-snippets",
		requires = {
			{ "nvim-mini/mini.completion" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	-- Surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", config = "config-treesitter" },
})

-- }}}
-- Colorscheme {{{

vim.cmd("silent! colorscheme gruvbox")

-- }}}
