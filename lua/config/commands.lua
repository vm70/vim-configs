-- Edit Vim RC file
vim.api.nvim_create_user_command("Vimrc", ":edit $MYVIMRC", { bang = true })

-- Quarto Commands
vim.api.nvim_create_user_command("QuartoPreview", ":terminal quarto preview", { bang = true })
vim.api.nvim_create_user_command("QuartoRender", ":terminal quarto render", { bang = true })

-- Accidental shift-commands
vim.api.nvim_create_user_command("W", ":w", { bang = true })
vim.api.nvim_create_user_command("WA", ":wa", { bang = true })
vim.api.nvim_create_user_command("WQ", ":wq", { bang = true })
vim.api.nvim_create_user_command("WQA", ":wqa", { bang = true })
vim.api.nvim_create_user_command("WQa", ":wqa", { bang = true })
vim.api.nvim_create_user_command("Wa", ":wa", { bang = true })
vim.api.nvim_create_user_command("Wq", ":wq", { bang = true })
vim.api.nvim_create_user_command("Wqa", ":wqa", { bang = true })
