-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettierd,
			require("formatter.filetypes.javascript").eslint_d,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
			require("formatter.filetypes.typescript").eslint_d,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
			require("formatter.filetypes.typescriptreact").eslint_d,
		},
		python = {
			require("formatter.filetypes.python").autopep8,
		},

		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.keymap.set("n", "<leader>fo", "<cmd>FormatWriteLock<cr>")
