require("mini.icons").setup({
	filetype = {
		["markdown.pandoc"] = { glyph = "󰍔", hl = "MiniIconsGrey" },
	},
})
require("mini.icons").mock_nvim_web_devicons()
require("mini.icons").tweak_lsp_kind()
