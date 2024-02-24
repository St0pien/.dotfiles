-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Disable windows bell
config.audible_bell = "Disabled"

config.color_scheme = 'Red Planet'

config.enable_tab_bar = false

config.font = wezterm.font('Cascadia Mono', { italic = false })
config.font_size = 13
config.font_rules = {
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font {
      family = 'Cascadia Mono',
      weight = 'Bold',
      italic = false
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'Cascadia Mono',
      weight = 'DemiBold',
      italic = false
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'Cascadia Mono',
      italic = false
    },
  },
}

config.initial_rows = 30
config.initial_cols = 120

config.default_domain = 'WSL:Ubuntu'

config.window_background_opacity = 1
config.window_background_image = 'C:\\Users\\Kuba\\Pictures\\term.png'

config.background = {
  {
    source = {
      File = 'C:\\Users\\Kuba\\Pictures\\term.png'
    },

    horizontal_align = 'Center',
    vertical_align = 'Middle',
  }
}

-- When opening inside windows switch to local domain

-- KeyBindings
config.keys = {
}

-- and finally, return the configuration to wezterm
return config
