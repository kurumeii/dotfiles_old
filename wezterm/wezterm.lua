local wez = require("wezterm")
local config = wez.config_builder()
local config_dir = wez.glob(wez.config_dir .. "/config/*.lua")

for _, file in ipairs(config_dir) do
	local tbl = dofile(file)
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			config[k] = v
		end
	end
end

return config
