local wez = require("wezterm")
local config = wez.config_builder()
local function merge_conf(config, t) end

for _, file in ipairs(wez.glob(wez.config_dir .. "/config/*.lua")) do
	local tbl = dofile(file)
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			config[k] = v
		end
	end
end

return config
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
