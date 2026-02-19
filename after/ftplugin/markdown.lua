vim.opt_local.autoindent = true
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 0
vim.opt_local.linebreak = true
vim.opt_local.spelloptions = ""
vim.opt_local.wrap = true

vim.keymap.set("i", "<C-BS>", "<C-W>", { buffer = true })
vim.keymap.set("i", "<S-Tab>", "<cmd><<CR>", { buffer = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { buffer = true })
vim.keymap.set("v", "<Tab>", ">gv", { buffer = true })

vim.g.markdown_folding = 1

vim.lsp.enable({ "ltex_plus", "marksman" })
