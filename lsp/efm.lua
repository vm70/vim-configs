local languages = {}
local ok, _ = pcall(require, "efmls-configs")
if ok then
	local fs = require("efmls-configs.fs")
	-- Formatters & Linters
	local cbfmt = require("efmls-configs.formatters.cbfmt")
	local checkmake = require("efmls-configs.linters.checkmake")
	local chktex = require("efmls-configs.linters.chktex")
	local latexindent = require("efmls-configs.formatters.latexindent")
	local prettier = require("efmls-configs.formatters.prettier")
	local selene = require("efmls-configs.linters.selene")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local vint = require("efmls-configs.linters.vint")
	-- Custom Formatters & Linters
	local cbfmt_quarto = {
		formatCommand = string.format(
			"%s --stdin-filepath '${INPUT}' --best-effort --parser markdown",
			fs.executable("cbfmt")
		),
		formatStdin = true,
	}
	local raco_fmt = {
		formatCommand = string.format("%s fmt", fs.executable("raco")),
		formatStdin = true,
	}
	-- Formatters & Linters by language
	languages = {
		css = { prettier },
		html = { prettier },
		json = { prettier },
		jsonc = { prettier },
		lua = { selene },
		make = { checkmake },
		markdown = { cbfmt, prettier },
		pandoc = { prettier },
		quarto = { cbfmt_quarto, prettier },
		racket = { raco_fmt },
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
