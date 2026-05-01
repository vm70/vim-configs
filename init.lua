-- vim: foldmethod=marker
-- Plugin Management {{{

vim.api.nvim_create_user_command("PackStatus", "lua =vim.pack.get()", { desc = "Get Package Status" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update Packages" })

vim.api.nvim_create_user_command("PackClean", function()
	vim.pack.del(vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable())
end, { desc = "Remove unused packages" })

vim.api.nvim_create_user_command("PackAdd", function(opts)
	local specs = {}
	for _, url in ipairs(opts.fargs) do
		table.insert(specs, { src = url })
	end
	vim.pack.add(specs)
end, { nargs = "+", desc = "Add package(s) manually" })

-- Manage post-install hooks
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		-- Auto-update Tree-sitter parsers
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- Download `mini.nvim`
vim.pack.add({ { src = "https://github.com/nvim-mini/mini.nvim" } })

MiniMisc = require("mini.misc")

-- }}}
-- Global Variables {{{

vim.g.filetype_v = "verilog"
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
-- Keymaps {{{

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Escape Terminal
vim.keymap.set("t", "<C-w>", "<C-\\><C-N><C-w>", { desc = "Escape terminal mode" })

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Stop highlight search" })

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

-- }}}
-- Commands {{{

vim.api.nvim_create_user_command("TrimWhitespace", require("mini.trailspace").trim, { desc = "Trim Whitespace" })

-- }}}
-- Autocommands {{{

vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nospell", desc = "Disable spelling on terminal windows" })

-- }}}
-- Plugin - Filetypes / Syntax {{{

MiniMisc.safely("now", function()
	vim.filetype.add({
		extension = {
			pu = "plantuml",
			puml = "plantuml",
			iuml = "plantuml",
		},
	})
	vim.pack.add({
		-- PlantUML
		{ src = "https://github.com/aklt/plantuml-syntax" },
		-- LaTeX
		{ src = "https://github.com/lervag/vimtex" },
		-- Quarto
		{ src = "https://github.com/quarto-dev/quarto-nvim" },
		{ src = "https://github.com/jmbuhr/otter.nvim" },
		{ src = "https://github.com/jpalardy/vim-slime" },
	})
end)

-- }}}
-- Plugin - Multi-Language LSP Servers {{{

MiniMisc.safely("now", function()
	vim.pack.add({
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/creativenull/efmls-configs-nvim" },
	})
	MiniMisc.safely("later", function()
		vim.lsp.enable({ "efm", "ltex_plus" })
	end)
end)

-- }}}
-- Plugin - Autocompletion {{{

MiniMisc.safely("now", function()
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

MiniMisc.safely("now", function()
	if vim.g.enable_treesitter then
		vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })
		vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" } })
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
		-- Append file types corresponding to each language to the file types table
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
	end
end)

-- }}}
-- Plugin - Color Scheme {{{

MiniMisc.safely("now", function()
	vim.pack.add({ { src = "https://github.com/ellisonleao/gruvbox.nvim" } })
	vim.cmd.colorscheme("gruvbox")
end)

-- }}}
-- Plugin - Icons {{{

MiniMisc.safely("now", function()
	require("mini.icons").setup({
		filetype = {
			fugitive = { glyph = "󰊢", hl = "MiniIconsOrange" },
			mermaid = { glyph = "󱁉", hl = "MiniIconsCyan" },
			plantuml = { glyph = "", hl = "MiniIconsGrey" },
		},
		extension = {
			v = vim.g.filetype_v,
		},
	})
	MiniMisc.safely("now", require("mini.icons").mock_nvim_web_devicons)
	MiniMisc.safely("later", require("mini.icons").tweak_lsp_kind)
end)

-- }}}
-- Plugin - Tab Line & Status Line {{{

MiniMisc.safely("now", function()
	require("mini.tabline").setup({ show_icons = true, tabpage_section = "right" })
end)
MiniMisc.safely("now", require("mini.statusline").setup)

-- }}}
-- Plugin - File Tree {{{

--- Add `nvim-tree` with my desired configurations.
MiniMisc.safely("now", function()
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })
	vim.keymap.set(
		"n",
		"<leader>E",
		"<cmd>NvimTreeToggle %:h<CR>",
		{ desc = "Toggle file tree, open at file's parent" }
	)
	vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
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

MiniMisc.safely("later", function()
	require("mini.git").setup()
	vim.pack.add({ { src = "https://github.com/tpope/vim-fugitive" } })
	require("mini.diff").setup({ view = { style = "sign" } })
end)

-- }}}
-- Plugin - Fuzzy Finding {{{

--- Create a Neovim command from the corresponding `mini.pick` picker name.
---@param picker string Picker name.
local function picker_command(picker)
	local pick_command = ""
	for word in string.gmatch(picker, "%w+") do
		pick_command = pick_command .. string.upper(string.sub(word, 1, 1)) .. string.sub(word, 2)
	end
	vim.api.nvim_create_user_command(pick_command, "Pick " .. picker, { desc = "MiniPick: " .. picker })
end

MiniMisc.safely("later", function()
	if vim.fn.executable("fzf") == 1 then
		-- Use fzf-lua (if fzf is available)
		vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })
		require("fzf-lua").setup({ "fzf-vim" })
		vim.api.nvim_create_user_command("Keymaps", "FzfLua keymaps", { desc = "Search for keymaps" })
	else
		-- Default to mini.pick
		require("mini.extra").setup()
		MiniPick = require("mini.pick")
		MiniPick.setup()
		for picker, _ in pairs(MiniPick.registry) do
			if picker ~= "cli" then
				picker_command(picker)
			end
		end
		vim.api.nvim_create_user_command("Rg", "Pick grep_live", { desc = "Live Grep (rg)" })
	end
end)

-- }}}
-- Plugin - AI Completion {{{

MiniMisc.safely("later", function()
	if vim.fn.executable("llama-server") == 1 then
		vim.g.llama_config = {
			enable_at_startup = false,
			keymap_inst_accept = "<Tab>",
			keymap_inst_cancel = "<Esc>",
			keymap_inst_continue = "<leader>llc",
			keymap_inst_retry = "<leader>llr",
			keymap_inst_trigger = "<leader>lli",
		}
		vim.pack.add({ { src = "https://github.com/ggml-org/llama.vim" } })
	end
end)

-- }}}
-- Plugin - Outline {{{

MiniMisc.safely("later", function()
	vim.pack.add({ { src = "https://github.com/hedyhli/outline.nvim" } })
	require("outline").setup({
		providers = {
			markdown = {
				filetypes = { "quarto", "markdown", "rmarkdown" },
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

MiniMisc.safely("later", function()
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

MiniMisc.safely("later", require("mini.bracketed").setup)
MiniMisc.safely("later", require("mini.move").setup)
MiniMisc.safely("later", require("mini.surround").setup)

MiniMisc.safely("later", function()
	local MiniAi = require("mini.ai")
	MiniAi.setup({
		custom_textobjects = {
			B = require("mini.extra").gen_ai_spec.buffer(),
			c = { "()# %%%%.-()# %%%%" },
			-- c = MiniAi.gen_spec.pair("# %%.*\n", "# %%", { type = "non-balanced" }),
			["$"] = MiniAi.gen_spec.pair("$", "$", { type = "non-balanced" }),
		},
		search_method = "cover",
	})
end)

MiniMisc.safely("later", function()
	require("mini.align").setup({
		mappings = {
			start = "<leader>La",
			start_with_preview = "<leader>LA",
		},
	})
end)

-- }}}
-- Plugin - Key Hints {{{

MiniMisc.safely("later", function()
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
-- Plugin - Sleuth {{{

MiniMisc.safely("now", function()
	vim.pack.add({ { src = "https://github.com/tpope/vim-sleuth" } })
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

MiniMisc.safely("later", function()
	vim.pack.add({ { src = "https://github.com/rafamadriz/friendly-snippets" } })
	local friendly_snippets_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/friendly-snippets/snippets"

	-- Define language patterns to work better with 'friendly-snippets'
	local latex_patterns = { "latex/**/*.json", "**/latex.json" }
	local lang_patterns = {
		bash = { "shell/*.json" },
		cpp = { "c/*.json", "cpp/*.json" },
		markdown_inline = { "markdown.json" },
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

MiniMisc.safely("later", function()
	-- Slime Options
	vim.g.slime_input_pid = false
	vim.g.slime_menu_config = false
	vim.g.slime_neovim_ignore_unlisted = false
	vim.g.slime_no_mappings = true
	vim.g.slime_suggest_default = true
	vim.g.slime_target = "neovim"
	-- Slime Keymaps
	vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Send code cell" })
	vim.pack.add({
		{ src = "https://github.com/jpalardy/vim-slime" },
	})
end)

-- }}}
