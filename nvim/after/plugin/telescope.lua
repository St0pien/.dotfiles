local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true, file_ignore_patterns = { "node%_modules/.*" } }) end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep >") });
end)
vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols)

require('telescope').load_extension('file_browser')

vim.keymap.set('n', "<leader>fb", ":Telescope file_browser<CR>")
