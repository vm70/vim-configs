-- Edit Vim RC file
vim.api.nvim_create_user_command("Vimrc", ":edit $MYVIMRC", { bang = true })

-- Quarto Commands
vim.api.nvim_create_user_command("QuartoPreview", ":terminal quarto preview", { bang = true })
vim.api.nvim_create_user_command("QuartoRender", ":terminal quarto render", { bang = true })
