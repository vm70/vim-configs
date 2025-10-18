-- selene: allow(unscoped_variables)

MiniIcons = require("mini.icons")
MiniIcons.setup({
	filetype = {
		["markdown.pandoc"] = { glyph = "󰍔", hl = "MiniIconsGrey" },
		plantuml = { glyph = "", hl = "MiniIconsGrey" },
	},
})
MiniIcons.mock_nvim_web_devicons()

-- Lazy-load `tweak_lsp_kind`
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		MiniIcons.tweak_lsp_kind()
	end,
})
