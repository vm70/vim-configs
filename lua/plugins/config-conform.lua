return {
	"stevearc/conform.nvim",
	opts = {
		default_format_opts = {
			timeout_ms = 10000,
			async = true,
			lsp_fallout = true,
		},
		format_on_save = {
			-- I recommend these options. See :help conform.format for details.
			lsp_format = "fallback",
			timeout_ms = 50000,
		},
		formatters = {
			injected = {
				options = {
					ignore_errors = true,
					lang_to_formatters = {
						python = { "black" },
					},
				},
			},
			-- black = {
			-- 	args = {
			-- 		"--stdin-filename",
			-- 		"$FILENAME",
			-- 		"--quiet",
			-- 		"--line-length",
			-- 		"79",
			-- 		"-",
			-- 	},
			-- },
			prettier = {
				options = {
					ext_parsers = {
						qmd = "markdown",
						pdc = "markdown",
						pandoc = "markdown",
					},
				},
			},
			-- raco_fmt = {
			-- 	command = "raco",
			-- 	args = { "fmt", "--indent", "2", "--width", "80" },
			-- 	stdin = true,
			-- 	cwd = require("conform.util").root_file({ ".fmt.rkt" }),
			-- 	require_cwd = false,
			-- 	exit_codes = { 0, 1 },
			-- },
		},
		formatters_by_ft = {
			go = { "gofumpt" },
			cpp = { "clang-format" },
			javascript = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier", "injected" },
			pandoc = { "prettier" },
			python = { "isort", "black", "ruff" },
			quarto = { "prettier", "injected" },
			racket = { "raco_fmt" },
			sh = { "shfmt" },
			toml = { "taplo" },
			yaml = { "prettier" },
			json = { "prettier" },
		},
	}
}
