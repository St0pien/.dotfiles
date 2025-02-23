return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'RRethy/base16-nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local theme = {
      base00 = '#000000',
      base01 = '#1f1d2e',
      base02 = '#23232a',
      base03 = '#2e2a30',
      base04 = '#908c9a',
      base05 = '#e0dee4',
      base06 = '#e0dee4',
      base07 = '#524f67',
      base08 = '#eb6f92',
      base09 = '#f6c177',
      base0A = '#ebbcba',
      base0B = '#31748f',
      base0C = '#9ccfd8',
      base0D = '#54a7f7',
      base0E = '#f6c177',
      base0F = '#524f67',
    }

    require('base16-colorscheme').setup(theme)

    vim.api.nvim_set_hl(0, 'CmpItemAbbr', { fg = theme.base05, bg = theme.base00 })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = theme.base05, bg = theme.base00 })
    vim.api.nvim_set_hl(0, 'PMenu', { fg = theme.base05, bg = theme.base00 })
  end,
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'base16-rose-pine'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
