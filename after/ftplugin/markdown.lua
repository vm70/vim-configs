vim.opt_local.autoindent = true
vim.opt_local.breakindent = true
vim.opt_local.linebreak = true
vim.opt_local.spelloptions = ""
vim.opt_local.wrap = true

vim.keymap.set("v", "<S-Tab>", "<gv", { buffer = true })
vim.keymap.set("v", "<Tab>", ">gv", { buffer = true })

-- Folding
vim.g.markdown_folding = 1
if vim.g.enable_treesitter then
	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo[0][0].foldmethod = "expr"
end

vim.lsp.enable({ "ltex_plus", "marksman" })
