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

-- For example, changing the color scheme:
local scheme = wezterm.get_builtin_color_schemes()['Dark+']
-- scheme.background = 'black'

config.color_schemes = {
    ['Dark+mod'] = scheme
}

config.audible_bell = "Disabled"

-- config.color_scheme = 'darkside'
config.color_scheme = 'Red Planet'

config.enable_tab_bar = false

config.font = wezterm.font 'Cascadia Mono'
config.font_size = 13

config.initial_rows = 30
config.initial_cols = 120

config.default_domain = 'WSL:Ubuntu'

-- config.window_background_opacity = 1
-- config.window_background_image = 'C:\\Users\\Kuba\\Pictures\\term.png'

config.background = {
  {
    source = {
      File = 'C:\\Users\\Kuba\\Pictures\\term.png'
    },

    horizontal_align = 'Center',
    vertical_align = 'Middle',
  }
}

FromContextMenu = false

wezterm.on('gui-startup', function(cmd)
  if (cmd.cwd ~= nil and string.match(cmd.cwd, '%u:\\')) then
    FromContextMenu = true
    local tab, pane, window = wezterm.mux.spawn_window({
      domain = { DomainName = 'local' },
      args = cmd.args
    })

    window:set_title('fromcontext')
  end
end
)

wezterm.on('gui-attached', function(domain)
  if (FromContextMenu) then
    FromContextMenu = false

    local windows = wezterm.mux:all_windows()
    for _, window in pairs(windows) do
      if (window:get_title() ~= 'fromcontext')then
        print(window:active_tab():active_pane():send_text('exit\n'))
      end
    end
  end
end)


-- and finally, return the configuration to wezterm
return config
