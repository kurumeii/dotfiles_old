--- @type Wezterm
local wez = require("wezterm")
local mods = {
	C = "CTRL",
	M = "ALT",
	S = "SHIFT",
	L = "LEADER",
}
local join_mods = function(m)
	local result = ""
	for i, v in ipairs(m) do
		result = result .. v
		if i < #m then
			result = result .. "|"
		end
	end
	return result
end

---@module "wezterm.wezterm"
---@type Config
return {
	leader = {
		key = "q",
		mods = mods.M,
		timeout_milliseconds = 1500,
	},
	keys = {
		{
			key = "n", -- Create new tab
			mods = mods.L,
			action = wez.action.SpawnTab("DefaultDomain"),
		},
		{
			key = "d", -- Duplicate tab
			mods = mods.L,
			action = wez.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "c", -- Close tab
			mods = mods.L,
			action = wez.action.CloseCurrentPane({
				confirm = true,
			}),
		},
		{
			key = "o",
			mods = mods.L,
			action = "ShowLauncher",
		},
		{
			key = "w", -- Close tab without confirm
			mods = mods.L,
			action = wez.action.CloseCurrentTab({
				confirm = true,
			}),
		},
		{
			key = "l", -- Split pane to the right
			mods = mods.L,
			action = wez.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "j", -- Split pane to the bottom
			mods = mods.L,
			action = wez.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "l", -- Focus next tab
			-- mods = mods.M .. "|" .. mods.S,
			mods = join_mods({ mods.M, mods.S }),
			action = wez.action.ActivateTabRelative(1),
		},
		{
			key = "h", -- Focus previous tab
			mods = join_mods({ mods.M, mods.S }),
			action = wez.action.ActivateTabRelative(-1),
		},
		{
			key = "LeftArrow", -- Focus Right Pane,
			mods = mods.M,
			action = wez.action.ActivatePaneDirection("Left"),
		},
		{
			key = "RightArrow", -- Focus Left Pane,
			mods = mods.M,
			action = wez.action.ActivatePaneDirection("Right"),
		},
		{
			key = "UpArrow", -- Focus Up Pane,
			mods = mods.M,
			action = wez.action.ActivatePaneDirection("Up"),
		},
		{
			key = "DownArrow", -- Focus Down Pane,
			mods = mods.M,
			action = wez.action.ActivatePaneDirection("Down"),
		},
		{
			key = "c",
			mods = join_mods({ mods.C, mods.S }),
			action = wez.action.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = join_mods({ mods.C, mods.S }),
			action = wez.action.PasteFrom("Clipboard"),
		},
		{
			key = "/",
			mods = mods.L,
			action = wez.action.PaneSelect({
				alphabet = "hljk",
			}),
		},
		-- Fonts size
		{
			key = "=",
			mods = mods.C,
			action = "IncreaseFontSize",
		},
		{
			key = "-",
			mods = mods.C,
			action = "DecreaseFontSize",
		},
		{
			key = "0",
			mods = mods.C,
			action = "ResetFontSize",
		},
	},
}
