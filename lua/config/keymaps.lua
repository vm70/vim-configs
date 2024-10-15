vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Stop highlight search
vim.keymap.set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

-- Commenting with Ctrl-/
vim.keymap.set("n", "<C-_>", "<C-v>gc<CR>k")
vim.keymap.set("v", "<C-_>", "gc<CR>k")

-- Moving lines up and down in code
vim.keymap.set("i", "<A-j>", "<cmd>m.+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<cmd>m.-2<CR>==gi")
vim.keymap.set("n", "<A-j>", "<cmd>m.+1<CR>==")
vim.keymap.set("n", "<A-k>", "<cmd>m.-2<CR>==")
vim.keymap.set("v", "<A-j>", "<cmd>m'>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", "<cmd>m'<-2<CR>gv=gv")
