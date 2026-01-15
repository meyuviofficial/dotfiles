-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 16.0

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingUnderline"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.text_background_opacity = 1.0
config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "/bin/zsh" }
-- and finally, return the configuration to wezterm

return config
