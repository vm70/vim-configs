local MiniDeps = require("mini.deps")
-- selene: allow(unused_variable)
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- LSP & EFM Configuration {{{

now(function()
	add({ source = "neovim/nvim-lspconfig" })
	add({ source = "creativenull/efmls-configs-nvim" })
end)

-- }}}
-- Autocompletion {{{

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
-- Jupyter / REPL {{{

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
-- Snippets {{{

later(function()
	add({ source = "rafamadriz/friendly-snippets" })
	-- Define language patterns to work better with 'friendly-snippets'
	local latex_patterns = { "latex/**/*.json", "**/latex.json" }
	local lang_patterns = {
		tex = latex_patterns,
		plaintex = latex_patterns,
		-- Recognize special injected language of markdown tree-sitter parser
		markdown_inline = { "markdown.json" },
	}

	local MiniSnippets = require("mini.snippets")
	MiniSnippets.setup({
		snippets = {
			-- Always load 'snippets/global.json' from config directory
			MiniSnippets.gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/global.json"),
			-- Load from 'snippets/' directory of plugins, like 'friendly-snippets'
			MiniSnippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
			require("dynamic-snippets"),
		},
		expand = {
			insert = function(snippet, _)
				vim.snippet.expand(snippet.body)
			end,
		},
	})

	-- By default snippets available at cursor are not shown as candidates in
	-- 'mini.completion' menu. This requires a dedicated in-process LSP server
	-- that will provide them. To have that, uncomment next line (use `gcc`).
	MiniSnippets.start_lsp_server()
end)

-- }}}
-- Multi-language LSP Servers {{{

later(function()
	vim.lsp.enable({ "efm", "ltex_plus" })
end)

-- }}}
