return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', '<cmd>vertical Git<CR>')
    vim.keymap.set('n', '<leader>gh', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', '<leader>gl', '<cmd>diffget //3<CR>')
    vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit!<CR>')
  end,
}
