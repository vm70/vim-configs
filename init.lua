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
-- Keymaps {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-N><C-\\>", { desc = "Escape terminal" })

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Stop highlight search" })

-- Commenting with Ctrl-/
vim.keymap.set("n", "<C-_>", "<C-v>gc<CR>k", { desc = "Toggle comment" })
vim.keymap.set("v", "<C-_>", "gc<CR>k", { desc = "Toggle comment" })

-- Moving lines up and down in code
vim.keymap.set("i", "<A-j>", "<cmd>m.+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<cmd>m.-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", "<cmd>m.+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m.-2<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-j>", "<cmd>m'>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", "<cmd>m'<-2<CR>gv=gv", { desc = "Move selection up" })

-- File tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Missing previous- and next- keys
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = ":bprevious" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = ":bnext" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous Git hunk" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Git hunk" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = ":tabprevious" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = ":tabnext" })

-- LSP Commands
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

-- Vim-Slime Commands
vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell")

-- }}}
-- Commands {{{

-- Whitespace Commands
vim.api.nvim_create_user_command("TrimWhitespace", ":%s\\/\\s\\+$/e | :nohlsearch", { bang = true })
vim.api.nvim_create_user_command("UseTabs", ":set noexpandtab | :set shiftwidth=2 | :set tabstop=2", { bang = true })
vim.api.nvim_create_user_command(
	"UseSpaces",
	":set expandtab | :set shiftwidth=<args> | :set tabstop=<args>",
	{ nargs = 1, bang = true }
)

-- }}}
-- Autocommands {{{

-- Disable spelling on terminal windows
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nospell" })

-- }}}
-- Filetypes {{{

vim.filetype.add({ extension = {
	pu = "plantuml",
	puml = "plantuml",
	iuml = "plantuml",
} })

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

local pckr = require("pckr")
local event = require("pckr.loader.event")
local cmd = require("pckr.loader.cmd")

pckr.setup({ autoremove = true, package_root = vim.fn.stdpath("config") })
pckr.add({
	-- Icons
	{ "nvim-mini/mini.icons", config = "config-icons" },
	-- Quickstart LSP Configuration
	{ "neovim/nvim-lspconfig" },
	-- File Tree
	{ "nvim-tree/nvim-tree.lua", requires = "nvim-mini/mini.icons", config = "config-nvim-tree" },
	-- Colorscheme
	{ "ellisonleao/gruvbox.nvim" },
	-- Status Line
	{
		"nvim-mini/mini.statusline",
		requires = {
			"nvim-mini/mini.icons",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("mini.statusline").setup()
		end,
	},
	{
		"nvim-mini/mini.tabline",
		requires = "nvim-mini/mini.icons",
		config = function()
			require("mini.tabline").setup({ tabpage_section = "right" })
		end,
	},
	-- Fuzzy Finding
	{ "ibhagwan/fzf-lua", cond = cmd("FzfLua") },
	-- Git Integration
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- Completion & Snippets
	{
		"nvim-mini/mini.completion",
		config = "config-completion",
		requires = {
			"nvim-mini/mini.icons",
			"nvim-mini/mini.snippets",
			"rafamadriz/friendly-snippets",
		},
	},
	-- Surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", config = "config-treesitter", run = ":TSUpdate" },
	-- Llama
	{
		"ggml-org/llama.vim",
		config_pre = "config-llama",
		cond = { cmd("LlamaDisable"), cmd("LlamaEnable"), cmd("LlamaToggle") },
	},
	-- Slime
	{
		"jpalardy/vim-slime",
		config_pre = function()
			vim.g.slime_target = "neovim"
		end,
		cond = event("BufReadPre", { "*.py", "*.jl" }),
	},
	{ "aklt/plantuml-syntax" },
})

-- }}}
-- Multi-Language LSP Setup {{{

-- Other filetype-specific LSPs get set up in `after/ftplugin/<filetype>.lua`.
vim.lsp.enable("ltex_plus")
vim.lsp.enable("efm")

-- }}}
-- Colorscheme {{{

vim.cmd("silent! colorscheme gruvbox")

-- }}}
