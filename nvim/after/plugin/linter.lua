require('lint').linters_by_ft = {
    markdown = { 'vale', },
    typescript = { 'eslint_d' },
    javascript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' }
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function()
        require('lint').try_lint()
    end
})
