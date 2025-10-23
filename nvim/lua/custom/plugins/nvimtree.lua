return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- empty setup using defaults
    require('nvim-tree').setup {
      git = {
        enable = true,
        ignore = false,
      },
    }

    local api = require 'nvim-tree.api'

    vim.keymap.set('n', '<leader>e', function()
      api.tree.toggle { find_file = true }
    end)

    vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = '#444444' })
  end,
}
