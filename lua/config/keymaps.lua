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

-- LSP Commands
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setqflist)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
