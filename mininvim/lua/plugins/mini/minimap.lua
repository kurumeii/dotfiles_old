require('mini.map').setup()

MiniMap.config.integrations = {
  MiniMap.gen_integration.builtin_search(),
  MiniMap.gen_integration.diagnostic(),
  MiniMap.gen_integration.diff(),
	-- MiniMap.gen_integration.gitsigns()
}

MiniMap.config.symbols.encode = MiniMap.gen_encode_symbols.dot('4x2')
MiniMap.config.window.width = 7
local utils = require('utils')
local map, L = utils.map, utils.L
--- Experimental features
-- vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
--   callback = function()
--     MiniMap.open()
--   end,
-- })

map('n', L('um'), MiniMap.toggle, 'UI Minimap Toggle')

map('n', L('us'), MiniMap.toggle_side, 'UI Minimap Toggle Side')
