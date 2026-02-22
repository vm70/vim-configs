vim.opt_local.conceallevel = 0
vim.opt_local.spell = false

if vim.fn.executable("jq") then
	vim.api.nvim_create_user_command("JsonSort", ":execute ':%!jq -S'", { desc = "Sort JSON file", bang = true })
end

vim.lsp.enable({ "jsonls" })
