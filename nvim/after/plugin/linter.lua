require("lint").linters_by_ft = {
	markdown = { "vale" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

local eslint = require("lint").linters.eslint_d

eslint.args = {
	"--no-warn-ignored", -- <-- this is the key argument
	"--format",
	"json",
	"--stdin",
	"--stdin-filename",
	function()
		return vim.api.nvim_buf_get_name(0)
	end,
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
