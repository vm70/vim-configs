-- Edit Vim RC file
vim.api.nvim_command("command! Vimrc :cd ~/.vim | edit $MYVIMRC")

-- Quarto Commands
vim.api.nvim_command("command! QuartoPreview :terminal quarto preview")
vim.api.nvim_command("command! QuartoRender :terminal quarto render")
