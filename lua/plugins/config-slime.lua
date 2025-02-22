vim.g.slime_target = "neovim"
vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell")
vim.api.nvim_create_user_command("SlimeSendCell", "<Plug>SlimeSendCell", { bang = true })
