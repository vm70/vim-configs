vim.opt_local.commentstring = "<!-- %s -->"
vim.opt_local.wrap = true

-- Quarto Commands
vim.api.nvim_create_user_command("QuartoPreview", ":terminal quarto preview", { bang = true })
vim.api.nvim_create_user_command("QuartoRender", ":terminal quarto render", { bang = true })
