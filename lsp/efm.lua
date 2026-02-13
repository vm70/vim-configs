local languages = {}
local ok, _ = pcall(require, "efmls-configs")
if ok then
	-- Formatters & Linters
	local cbfmt = require("efmls-configs.formatters.cbfmt")
	local chktex = require("efmls-configs.linters.chktex")
	local latexindent = require("efmls-configs.formatters.latexindent")
	local prettier = require("efmls-configs.formatters.prettier")
	local selene = require("efmls-configs.linters.selene")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local vint = require("efmls-configs.linters.vint")
	-- Formatters & Linters by language
	languages = {
		css = { prettier },
		html = { prettier },
		json = { prettier },
		lua = { selene },
		markdown = { cbfmt, prettier },
		pandoc = { prettier },
		quarto = { cbfmt, prettier },
		scss = { prettier },
		sh = { shfmt },
		tex = { chktex, latexindent },
		vim = { vint },
		yaml = { prettier },
	}
end

---@type vim.lsp.Config
return {
	init_options = { documentFormatting = true, documentRangeFormatting = true },
	cmd = { "efm-langserver" },
	filetypes = vim.tbl_keys(languages),
	settings = {
		languages = languages,
	},
}
