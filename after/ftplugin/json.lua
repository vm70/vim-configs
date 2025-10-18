vim.opt_local.conceallevel = 0
vim.opt_local.spell = false

if vim.fn.executable("jq") then
	vim.api.nvim_create_user_command("SortJSON", ":execute ':%!jq -S", { bang = true })
end
