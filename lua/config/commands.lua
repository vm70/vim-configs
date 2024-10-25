-- Edit Vim RC file
vim.api.nvim_create_user_command("Vimrc", ":edit $MYVIMRC", {bang = true})
