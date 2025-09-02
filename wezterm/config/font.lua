---@type Wezterm
local wez = require("wezterm")

---@type Config
return {
	font = wez.font("FiraCode Nerd Font"),
	font_size = 12,
	freetype_load_target = "Light",
	front_end = "WebGpu",
	enable_kitty_graphics = true,
	underline_thickness = 1,
	-- line_height = 1.1,
}
