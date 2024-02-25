-- Leader remap
vim.g.mapleader = " "

-- Project explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww $REPOS/.dotfiles/shcripts/repofinder.sh<CR>")

vim.keymap.set("n", "<leader>fo", function()
    vim.lsp.buf.format()
end)

-- System clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "=", "<cmd>vertical resize +5<cr>")
vim.keymap.set("n", "-", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "+", "<cmd>horizontal resize +5<cr>")
vim.keymap.set("n", "_", "<cmd>horizontal resize -5<cr>")

