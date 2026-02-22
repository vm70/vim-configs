-- Install the Julia LSP server according to nvim-lspconfig.
local function julia_lsp_install()
	vim.cmd(
		[[terminal julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer"); Pkg.add("StaticLint")']]
	)
end

-- Update the Julia LSP server according to nvim-lspconfig.
local function julia_lsp_update()
	vim.cmd([[terminal julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()']])
end

vim.api.nvim_create_user_command(
	"JuliaLspInstall",
	julia_lsp_install,
	{ desc = "Install Julia LSP Server", bang = true }
)
vim.api.nvim_create_user_command("JuliaLspUpdate", julia_lsp_update, { desc = "Update Julia LSP Server", bang = true })

vim.lsp.enable("julials")
