vim.g.markdown_folding = 1

vim.opt_local.spelloptions = ""
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 0

vim.keymap.set("i", "<C-BS>", "<C-W>")
vim.keymap.set("i", "<S-Tab>", "<cmd><<CR>")

vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")
