-- Define languages which will have parsers installed and auto enabled
-- After changing this, restart Neovim once to install necessary parsers. Wait
-- for the installation to finish before opening a file for added language(s).
local languages = {
	"lua",
	"vimdoc",
	"markdown",
	"python",
}
local isnt_installed = function(lang)
	return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then
	require("nvim-treesitter").install(to_install)
end

-- Enable tree-sitter after opening a file for a target language
local filetypes = {}
for _, lang in ipairs(languages) do
	for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
		table.insert(filetypes, ft)
	end
end
local ts_start = function(ev)
	vim.treesitter.start(ev.buf)
end
vim.api.nvim_create_autocmd("Filetype", { pattern = filetypes, callback = ts_start, desc = "Start tree-sitter" })
