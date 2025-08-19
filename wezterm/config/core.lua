---@module 'wezterm.wezterm'
---@type Config

local wsl_distro = "Ubuntu"

return {
	launch_menu = {
		{
			label = " PowerShell",
			args = { "pwsh.exe" },
		},
		{
			label = " linux",
			args = { "wsl.exe", "-d", wsl_distro, "--cd", "~" },
		},
	},
	default_prog = { "wsl.exe", "-d", wsl_distro },
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 500,
	prefer_egl = true,
	max_fps = 120,
}
