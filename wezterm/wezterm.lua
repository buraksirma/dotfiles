-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#050508"

-- Overriden by plugin
-- custom.tab_bar.inactive_tab_hover.bg_color = "#050508"
-- custom.tab_bar.active_tab.fg_color = "#050508"
custom.tab_bar.background = "rgba(5,5,8,0.6)"
custom.cursor_fg = "#050508"
config.color_schemes = { ["Darkppuccin"] = custom }
config.color_scheme = "Darkppuccin"

config.font = wezterm.font({
	family = "JetBrainsMonoNL Nerd Font Mono",
	weight = "Bold",
})
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.font_size = 16.0
config.window_background_opacity = 0.6
config.window_decorations = "RESIZE"
config.tab_max_width = 24
config.window_padding = {
	left = 2,
	right = 2,
	top = 5,
	bottom = 0,
}

require("bar").apply_to_config(config, {
	position = "top",
	max_width = 32,
	dividers = "slant_left", -- or "slant_left", "arrows", "rounded", false
	indicator = {
		leader = {
			enabled = true,
			off = "",
			on = "",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic", -- or "roman"
		pane_count = "superscript", -- or "subscript", false
		brackets = {
			active = { "", "" },
			inactive = { "", "" },
		},
	},
	clock = { -- note that this overrides the whole set_right_status
		enabled = true,
		format = "%Y-%m-%d %X", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
	},
})

for k, v in pairs(require("keybindings")) do
	config[k] = v
end

return config
