-- Define languages which will have parsers installed and auto-enabled
local languages = {
	"lua",
	"vimdoc",
	"markdown",
	"python",
	"julia",
}

-- Define filetypes that have no corresponding treesitter parser / language
local filetypes = {
	"quarto",
}

-- Auto-install parsers
local isnt_installed = function(lang)
	return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then
	require("nvim-treesitter").install(to_install)
end

-- Append filetypes corresponding to each language to the filetypes table
for _, lang in ipairs(languages) do
	for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
		table.insert(filetypes, ft)
	end
end

-- Enable tree-sitter after opening a file for a target language / filetype
vim.api.nvim_create_autocmd("Filetype", {
	pattern = filetypes,
	desc = "Start tree-sitter",
	callback = function(ev)
		vim.treesitter.start(ev.buf)
	end,
})
