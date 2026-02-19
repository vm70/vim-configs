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

-- stylua: ignore start

-- Seed random variables for snippet generation
math.randomseed(vim.loop.hrtime())

--- Missing snippet variables in Neovim. Stolen from `mini.snippets.H.var_evaluators`.
---@type { [string]: function }
local snippet_vars = {
	-- VS Code
	CLIPBOARD         = function() return vim.fn.getreg("+") end,
	CURSOR_INDEX      = function() return tostring(vim.fn.col(".") - 1) end,
	CURSOR_NUMBER     = function() return tostring(vim.fn.col(".")) end,
	RELATIVE_FILEPATH = function() return vim.fn.expand("%:.") end,
	WORKSPACE_FOLDER  = function() return vim.fn.getcwd() end,
	LINE_COMMENT      = function() return vim.bo.commentstring:gsub("%s*%%s.*$", "") end,
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
	RANDOM     = function() return string.format("%06d", math.random(0, 999999)) end,
	RANDOM_HEX = function() return string.format("%06x", math.random(0, 16777216 - 1)) end,
	UUID       = function()
		local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
		return string.gsub(template, "[xy]", function(c)
			local v = c == "x" and math.random(0, 0xf) or math.random(8, 0xb)
			return string.format("%x", v)
		end)
	end,
}

-- stylua: ignore end

later(function()
	add({ source = "rafamadriz/friendly-snippets" })
	local friendly_snippets_path = MiniDeps.config.path.package .. "/pack/deps/opt/friendly-snippets/snippets"

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
-- Multi-language LSP Servers {{{

later(function()
	vim.lsp.enable({ "efm", "ltex_plus" })
end)

-- }}}
