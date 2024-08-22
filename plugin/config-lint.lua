require("lint").linters_by_ft = {
	markdown = { "write_good" },
	lua = { "selene" },
	vim = { "vint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
