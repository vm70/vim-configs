-- Return common settings for `prettier`.
---@param filetype string file type
---@return {formatCommand: string, formatStdin: boolean} prettier_settings EFM settings
local function prettier_settings(filetype)
	return {
		formatCommand = vim.fn.expand("$HOME") .. "/.npm/bin/prettier --parser " .. filetype,
		formatStdin = true,
	}
end

local efm_settings = {
	languages = {
		css = {
			prettier = prettier_settings("css"),
		},
		html = {
			prettier = prettier_settings("html"),
		},
		json = {
			prettier = prettier_settings("json"),
		},
		lua = {
			selene = {
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
		},
		markdown = {
			prettier = prettier_settings("markdown"),
		},
		["markdown.pandoc"] = {
			prettier = prettier_settings("markdown"),
		},
		md = {
			prettier = prettier_settings("markdown"),
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
			prettier = prettier_settings("markdown"),
		},
		scss = {
			prettier = prettier_settings("scss"),
		},
		sh = {
			shfmt = {
				formatCommand = "shfmt",
				formatStdin = true,
			},
		},
		vim = {
			vint = {
				prefix = "vint",
				lintCommand = "vint -",
				lintStdin = true,
				lintFormats = {
					"%f:%l:%c: %m",
				},
			},
		},
		yaml = {
			prettier = prettier_settings("yaml"),
		},
	},
}
---@type vim.lsp.Config
return {
	cmd = { "/usr/bin/efm-langserver" },
	filetypes = vim.tbl_keys(efm_settings.languages),
	root_markers = {},
	settings = efm_settings,
}
