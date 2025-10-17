-- Return common settings for `prettier`.
---@param filetype string file type
---@return {formatCommand: string, formatStdin: boolean} settings EFM settings
local function prettier_settings(filetype)
	return {
		formatCommand = vim.fn.expand("$HOME") .. "/.npm/bin/prettier --parser " .. filetype,
		formatStdin = true,
	}
end

local efm_settings = {
	languages = {
		css = {
			prettier_settings("css"),
		},
		html = {
			prettier_settings("html"),
		},
		json = {
			prettier_settings("json"),
		},
		lua = {
			{
				prefix = "selene",
				lintIgnoreExitCode = true,
				lintCommand = "selene --color never --quiet -",
				lintStdin = true,
				lintFormats = {
					"%f:%l:%c: %trror%m",
					"%f:%l:%c: %tarning%m",
					"%f:%l:%c: %tote%m",
				},
				rootMarkers = {
					"selene.toml",
				},
			},
			{
				prefix = "stylua",
				formatCanRange = true,
				formatCommand = vim.fn.expand("$HOME")
					.. "/.cargo/bin/stylua --color=Never ${--range-start=charStart} ${--range-end=charEnd} --stdin-filepath '${INPUT}' -",
				formatStdin = true,
			},
		},
		markdown = {
			prettier_settings("markdown"),
		},
		["markdown.pandoc"] = {
			prettier_settings("markdown"),
		},
		md = {
			prettier_settings("markdown"),
		},
		quarto = {
			-- Heads-up, this will only work if you add the following to your `.prettierrc.yaml` file:
			--
			-- ```yaml
			-- overrides:
			--   - files: "**.qmd"
			--     options:
			--       parser: "markdown"
			-- ```
			prettier_settings("markdown"),
		},
		scss = {
			prettier_settings("scss"),
		},
		sh = {
			{
				formatCommand = "shfmt",
				formatStdin = true,
			},
		},
		vim = {
			{
				prefix = "vint",
				lintCommand = "vint -",
				lintStdin = true,
				lintFormats = {
					"%f:%l:%c: %m",
				},
			},
		},
		yaml = {
			prettier_settings("yaml"),
		},
	},
}
---@type vim.lsp.Config
return {
	init_options = { documentFormatting = true, documentRangeFormatting = true },
	cmd = { "/usr/bin/efm-langserver" },
	filetypes = vim.tbl_keys(efm_settings.languages),
	root_markers = { ".git" },
	settings = efm_settings,
}
