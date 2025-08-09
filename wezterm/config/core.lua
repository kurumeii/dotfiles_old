---@module 'wezterm.wezterm'
---@type Config
return {
	launch_menu = {
		{
			label = " PowerShell",
			args = { "pwsh.exe" },
		},
		{
			label = " linux",
			args = { "wsl.exe", "-e", "~" },
		},
	},
	default_prog = { "pwsh.exe" },
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 500,
	prefer_egl = true,
	max_fps = 120,
}
