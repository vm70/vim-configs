-- vim: foldmethod=marker
-- Plugin Management {{{

---Load a package with options specified in the `data` table.
---
---Current options:
--- - use `type = "lazy"` to not immediately load a package
---
---@param plug_data {spec: vim.pack.Spec, path: string}
local function load_with_options(plug_data)
	if plug_data.spec.data == nil then
		vim.cmd.packadd(plug_data.spec.name)
		return
	end
	if plug_data.spec.data.type ~= "lazy" then
		vim.cmd.packadd(plug_data.spec.name)
	end
end

vim.pack.add({
	-- mini.nvim
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	-- Filetype & Syntax Plugins
	{ src = "https://github.com/aklt/plantuml-syntax" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/vim-pandoc/vim-pandoc" },
	{ src = "https://github.com/vim-pandoc/vim-pandoc-syntax" },
	{ src = "https://github.com/vim-pandoc/vim-rmarkdown" },
	{ src = "https://github.com/quarto-dev/quarto-vim" },
	-- LSP Configuration
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/creativenull/efmls-configs-nvim" },
	-- Color Scheme
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	-- Snippets
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	-- Fuzzy Finding
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	-- Outline
	{ src = "https://github.com/hedyhli/outline.nvim" },
	-- File Tree
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	-- Sleuth
	{ src = "https://github.com/tpope/vim-sleuth" },
	-- Quarto
	{ src = "https://github.com/quarto-dev/quarto-nvim" },
	{ src = "https://github.com/jmbuhr/otter.nvim" },
	-- Git Integration
	{ src = "https://github.com/tpope/vim-fugitive", data = { type = "lazy" } },
	-- Treesitter
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		data = { type = "lazy" },
	},
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		data = { type = "lazy" },
	},
	{ src = "https://github.com/ggml-org/llama.vim", data = { type = "lazy" } },
	-- Vim-Slime
	{ src = "https://github.com/jpalardy/vim-slime", data = { type = "lazy" } },
	{ src = "https://github.com/Klafyvel/vim-slime-cells", data = { type = "lazy" } },
}, { load = load_with_options })

-- Manage post-install hooks
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

local function now(func)
	require("mini.misc").safely("now", func)
end

local function later(func)
	require("mini.misc").safely("later", func)
end

-- }}}
-- Global Variables {{{

vim.g.filetype_md = "pandoc"
vim.g.filetype_v = "verilog"

-- Custom Global Variables
vim.g.enable_treesitter = (true and vim.fn.executable("tree-sitter") == 1)

-- }}}
-- Options {{{

-- Visuals
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "+" }
vim.opt.number = true
vim.opt.showbreak = "↪ "
vim.opt.termguicolors = true
vim.opt.title = true

-- Editing
vim.opt.autoread = true
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
vim.opt.foldlevelstart = 6
vim.opt.foldmethod = "marker"
vim.opt.incsearch = true
vim.opt.iskeyword = "@,48-57,_,192-255,-"
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"

-- Window Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Diff options
vim.opt.diffopt = { "internal", "filler", "closeoff", "vertical" }

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
-- Filetypes & Syntax Plugins {{{

vim.filetype.add({
	extension = {
		pu = "plantuml",
		puml = "plantuml",
		iuml = "plantuml",
	},
})

-- }}}
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
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "grl", vim.lsp.codelens.run, { desc = "Run code lens" })
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist, { desc = "View diagnostics in quickfix list" })

-- Vim-Slime / Vim-Slime-Cells
vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Send code cell" })
vim.keymap.set("n", "<leader>sC", "<Plug>SlimeCellsSendAndGoToNext", { desc = "Send code cell & go to next" })
vim.keymap.set("n", "<leader>sj", "<Plug>SlimeCellsNext", { desc = "Code cell forward" })
vim.keymap.set("n", "<leader>sk", "<Plug>SlimeCellsPrev", { desc = "Code cell backward" })

-- }}}
-- Commands {{{

vim.api.nvim_create_user_command("Keymaps", "FzfLua keymaps", { desc = "Search for keymaps" })
vim.api.nvim_create_user_command("PackStatus", "lua =vim.pack.get()", { desc = "Get Package Status" })
vim.api.nvim_create_user_command("PackUpdate", "lua =vim.pack.update()", { desc = "Update Packages" })
vim.api.nvim_create_user_command("TrimWhitespace", require("mini.trailspace").trim, { desc = "Trim Whitespace" })

-- }}}
-- Autocommands {{{

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nospell", desc = "Disable spelling on terminal windows" })

-- }}}
-- Plugin - Multi-Language LSP Servers {{{

later(function()
	vim.lsp.enable({ "efm", "ltex_plus" })
end)

-- }}}
-- Plugin - Autocompletion {{{

now(function()
	-- Customize post-processing of LSP responses for a better user experience.
	-- Don't show 'Text' suggestions (usually noisy) and show snippets last.
	local process_items = function(items, base)
		return require("mini.completion").default_process_items(
			items,
			base,
			{ kind_priority = { Text = -1, Snippet = 99 } }
		)
	end
	require("mini.completion").setup({
		lsp_completion = {
			-- Without this config autocompletion is set up through `:h 'completefunc'`.
			-- Although not needed, setting up through `:h 'omnifunc'` is cleaner
			-- (sets up only when needed) and makes it possible to use `<C-u>`.
			source_func = "omnifunc",
			auto_setup = false,
			process_items = process_items,
		},
	})

	-- Set 'omnifunc' for LSP completion only when needed.
	local on_attach = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
	end
	vim.api.nvim_create_autocmd("LspAttach", {
		pattern = nil,
		callback = on_attach,
		desc = "Set omnifunc",
	})

	-- Advertise to servers that Neovim now supports certain set of completion and
	-- signature features through 'mini.completion'.
	vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })
end)

-- }}}
-- Plugin - Treesitter {{{

local parser_not_installed = function(lang)
	return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end

if vim.g.enable_treesitter == true then
	now(function()
		vim.cmd.packadd("nvim-treesitter")
		vim.cmd.packadd("nvim-treesitter-textobjects")
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
			"pandoc",
			"quarto",
		}
		-- Auto-install parsers
		local to_install = vim.tbl_filter(parser_not_installed, languages)
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end
		-- -- Append file types corresponding to each language to the file types table
		for _, lang in ipairs(languages) do
			for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
				table.insert(filetypes, ft)
			end
		end
		-- Enable tree-sitter after opening a file for a target language / file type
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			desc = "Start tree-sitter",
			callback = function(ev)
				vim.treesitter.start(ev.buf)
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
			end,
		})
	end)
end

-- }}}
-- Plugin - Color Scheme {{{

now(function()
	vim.cmd.colorscheme("gruvbox")
end)

-- }}}
-- Plugin - Icons {{{

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
-- Plugin - Tab Line & Status Line {{{

now(function()
	require("mini.tabline").setup({ show_icons = true, format = nil, tabpage_section = "right" })
end)
now(require("mini.statusline").setup)

-- }}}
-- Plugin - File Tree {{{

--- Add `nvim-tree` with my desired configurations.
now(function()
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
-- Plugin - Git Integration {{{

later(function()
	require("mini.git").setup()
	vim.cmd.packadd("vim-fugitive")
	require("mini.diff").setup({ view = { style = "sign" } })
end)

-- }}}
-- Plugin - Fuzzy Finding {{{

later(function()
	require("fzf-lua").setup({ "fzf-vim" })
end)

-- }}}
-- Plugin - AI Completion {{{

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
		vim.cmd.packadd("llama.vim")
	end)
end

-- }}}
-- Plugin - Outline {{{

later(function()
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
-- Plugin - Highlight Patterns {{{

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
-- Plugin - Extra Keymaps {{{

later(require("mini.bracketed").setup)
later(require("mini.move").setup)
later(require("mini.surround").setup)

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

later(function()
	require("mini.align").setup({
		mappings = {
			start = "<leader>La",
			start_with_preview = "<leader>LA",
		},
	})
end)

-- }}}
-- Plugin - Key Hints {{{

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
-- Plugin - Snippets {{{

-- Seed random variables for snippet generation
math.randomseed(vim.loop.hrtime())

-- stylua: ignore start

--- Missing snippet variables in Neovim. Stolen from `mini.snippets.H.var_evaluators`.
---@type { [string]: function }
local snippet_vars = {
	-- VS Code
	CLIPBOARD                = function() return vim.fn.getreg("+") end,
	CURSOR_INDEX             = function() return tostring(vim.fn.col(".") - 1) end,
	CURSOR_NUMBER            = function() return tostring(vim.fn.col(".")) end,
	RELATIVE_FILEPATH        = function() return vim.fn.expand("%:.") end,
	WORKSPACE_FOLDER         = function() return vim.fn.getcwd() end,
	LINE_COMMENT             = function() return vim.bo.commentstring:gsub("%s*%%s.*$", "") end,
	-- Time
	CURRENT_YEAR             = function() return vim.fn.strftime("%Y") end,
	CURRENT_YEAR_SHORT       = function() return vim.fn.strftime("%y") end,
	CURRENT_MONTH            = function() return vim.fn.strftime("%m") end,
	CURRENT_MONTH_NAME       = function() return vim.fn.strftime("%B") end,
	CURRENT_MONTH_NAME_SHORT = function() return vim.fn.strftime("%b") end,
	CURRENT_DATE             = function() return vim.fn.strftime("%d") end,
	CURRENT_DAY_NAME         = function() return vim.fn.strftime("%A") end,
	CURRENT_DAY_NAME_SHORT   = function() return vim.fn.strftime("%a") end,
	CURRENT_HOUR             = function() return vim.fn.strftime("%H") end,
	CURRENT_MINUTE           = function() return vim.fn.strftime("%M") end,
	CURRENT_SECOND           = function() return vim.fn.strftime("%S") end,
	CURRENT_TIMEZONE_OFFSET  = function() return vim.fn.strftime("%z") end,
	CURRENT_SECONDS_UNIX     = function() return tostring(os.time()) end,
	-- Random
	RANDOM                   = function() return string.format("%06d", math.random(0, 999999)) end,
	RANDOM_HEX               = function() return string.format("%06x", math.random(0, 16777216 - 1)) end,
	UUID                     = function()
		local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
		return string.gsub(template, "[xy]", function(c)
			local v = c == "x" and math.random(0, 0xf) or math.random(8, 0xb)
			return string.format("%x", v)
		end)
	end,
}

-- stylua: ignore end

later(function()
	local friendly_snippets_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/friendly-snippets/snippets"

	-- Define language patterns to work better with 'friendly-snippets'
	local latex_patterns = { "latex/**/*.json", "**/latex.json" }
	local lang_patterns = {
		bash = { "shell/*.json" },
		cpp = { "c/*.json", "cpp/*.json" },
		markdown_inline = { "markdown.json" },
		pandoc = { "pandoc.json", "markdown.json" },
		plaintex = latex_patterns,
		sh = { "shell/*.json" },
		tex = latex_patterns,
	}

	local MiniSnippets = require("mini.snippets")
	MiniSnippets.setup({
		snippets = {
			-- Always load 'snippets/global.json' from config directory
			MiniSnippets.gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
			-- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
			MiniSnippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
			-- Load global snippets from `friendly-snippets`
			MiniSnippets.gen_loader.from_file(friendly_snippets_path .. "/global.json"),
			MiniSnippets.gen_loader.from_file(friendly_snippets_path .. "/loremipsum.json"),
		},
		expand = {
			insert = function(snippet, _)
				-- Insert missing snippet variables
				local new_snippet_body = snippet.body
				for var, evaluator in pairs(snippet_vars) do
					if string.find(new_snippet_body, var) ~= nil then
						new_snippet_body = string.gsub(new_snippet_body, "${" .. var .. "}", evaluator())
						new_snippet_body = string.gsub(new_snippet_body, "$" .. var, evaluator())
					end
				end
				-- Expand the modified snippet using the native snippet engine
				vim.snippet.expand(new_snippet_body)
			end,
		},
	})

	-- By default snippets available at cursor are not shown as candidates in
	-- 'mini.completion' menu. This requires a dedicated in-process LSP server
	-- that will provide them. To have that, uncomment next line (use `gcc`).
	MiniSnippets.start_lsp_server()
end)

-- }}}
-- Plugin - Jupyter / REPL {{{

later(function()
	vim.g.slime_target = "neovim"
	vim.g.slime_no_mappings = true
	vim.g.slime_cell_delimiter = "^# %%.*$"
	vim.g.slime_python_ipython = (vim.fn.executable("ipython") == 1) or (vim.fn.executable("ipython3") == 1)
	vim.g.slime_input_pid = false
	vim.g.slime_suggest_default = true
	vim.g.slime_menu_config = false
	vim.g.slime_neovim_ignore_unlisted = false
	vim.g.slime_cells_no_highlight = 1
	vim.cmd.packadd("vim-slime")
	vim.cmd.packadd("vim-slime-cells")
end)

-- }}}
-- Plugin - Quarto {{{

later(function()
	-- Quarto (for Neovim), LSP integration, relies on Treesitter
	require("quarto").setup()
end)

-- }}}
