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

return {
	leader = {
		key = " ",
		mods = "CTRL",
		timeout_milliseconds = 1500,
	},
	keys = {
		{
			key = "t", -- Create new tab
			mods = mods.L,
			action = wez.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "d", -- Delete tab
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
			key = "c", -- Close pane
			mods = mods.L,
			action = wez.action.CloseCurrentPane({
				confirm = true,
			}),
		},
		{
			key = "l", -- Focus next tab
			-- mods = mods.M .. "|" .. mods.S,
			mods = join_mods({ mods.M, mods.S }),
			action = wez.action.ActivateTabRelative(-1),
		},
		{
			key = "h", -- Focus previous tab
			mods = join_mods({ mods.M, mods.S }),
			action = wez.action.ActivateTabRelative(1),
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
			mods = join_mods({ mods.C }),
			action = wez.action.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = join_mods({ mods.C }),
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
			action = wez.action.IncreaseFontSize(),
		},
		{
			key = "-",
			mods = mods.C,
			action = wez.action.DecreaseFontSize(),
		},
		{
			keys = '0',
			mods = mods.C,
			action = wez.action.ResetFontAndWindowSize()
		}
	},
}
