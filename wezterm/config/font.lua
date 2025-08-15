---@type Wezterm
local wez = require("wezterm")

---@type Config
return {
	font = wez.font("GeistMono Nerd Font", {
		weight = "Light",
	}),
	font_size = 11,
	freetype_load_target = "HorizontalLcd",
	front_end = "WebGpu",
	enable_kitty_graphics = true,
	underline_thickness = 1,
	line_height = 1.1,
}
