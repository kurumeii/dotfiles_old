---@type Wezterm
local wez = require("wezterm")

---@type Config
return {
	font = wez.font("FiraCode Nerd Font", {
		weight = "Regular",
	}),
	font_size = 11,
	freetype_load_target = "Light",
}
