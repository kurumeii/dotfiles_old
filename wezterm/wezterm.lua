local term = require("wezterm")

local config = term.config_builder()
config.font = term.font({
	family = "CaskaydiaCove Nerd Font",
})
config.font_size = 12
config.color_scheme = "catppuccin-mocha"
config.default_prog = {
	"pwsh.exe",
}
config.default_gui_startup_args = {
	"start",
	-- "--fullsize",
}
config.enable_scroll_bar = true
config.window_background_opacity = 0
config.macos_window_background_blur = 20
config.win32_system_backdrop = "Tabbed"

-- config.keys = {
-- 	{
-- 		key = "h",
-- 		mods = "CTRL|SHIFT",
-- 		action = term.action.ActivateTabRelative(-1),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "CTRL|SHIFT",
-- 		action = term.action.ActivateTabRelative(1),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "ALT|SHIFT",
-- 		action = term.action.SplitHorizontal({
-- 			domain = "CurrentPaneDomain",
-- 		}),
-- 	},
-- 	{
-- 		key = "j",
-- 		mods = "ALT|SHIFT",
-- 		action = term.action.SplitVertical({
-- 			domain = "CurrentPaneDomain",
-- 		}),
-- 	},
-- 	{
-- 		key = "h",
-- 		mods ="ALT",
-- 		action = term.action.ActivePaneDirection("Left"),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods ="ALT",
-- 	}
-- }

return config
