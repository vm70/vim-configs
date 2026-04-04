-- Install the Julia LSP server according to nvim-lspconfig.
local function lsp_julia_install()
	vim.cmd(
		[[terminal julia --project=$HOME/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer"); Pkg.add("StaticLint")']]
	)
end

-- Update the Julia LSP server according to nvim-lspconfig.
local function lsp_julia_update()
	vim.cmd([[terminal julia --project=$HOME/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()']])
end

-- Instantiate the Julia LSP server according to nvim-lspconfig.
local function lsp_julia_instantiate()
	local abspath = vim.fs.abspath(".")
	vim.fn.system({
		"julia",
		"--project=" .. abspath,
		"-e",
		"'using Pkg; Pkg.instantiate()'",
	})
end

vim.api.nvim_create_user_command(
	"LspJuliaInstall",
	lsp_julia_install,
	{ desc = "Install Julia LSP Server", bang = true }
)

vim.api.nvim_create_user_command("LspJuliaUpdate", lsp_julia_update, { desc = "Update Julia LSP Server", bang = true })

vim.api.nvim_create_user_command(
	"LspJuliaInstantiate",
	lsp_julia_instantiate,
	{ desc = "Instantiate Julia LSP Server here", bang = true }
)

vim.lsp.enable("julials")
