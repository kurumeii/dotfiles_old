local term = require("wezterm")

local config = term.config_builder()
config.font = term.font("CaskaydiaCove Nerd Font")
config.color_scheme = "tokyonight"
config.default_prog = {
	"pwsh.exe",
}

return config
