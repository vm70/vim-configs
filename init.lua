-- Bootstrap `mini.nvim` & MiniDeps {{{

-- Clone `mini.nvim` manually in a way that it gets managed by `mini.deps`
local plugin_path = vim.fn.stdpath("config")
local mini_nvim_path = plugin_path .. "/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_nvim_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.nvim",
		mini_nvim_path,
	})
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up `mini.deps`
MiniDeps = require("mini.deps")
MiniDeps.setup({ path = { package = plugin_path } })

-- Set up `mini.extra` (since other plugins are dependent on it)
MiniDeps.later(require("mini.extra").setup)
