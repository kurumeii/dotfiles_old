require('mini.map').setup()

MiniMap.config.integrations = {
  MiniMap.gen_integration.builtin_search(),
  MiniMap.gen_integration.diagnostic({
		error = 'DiagnosticFloatingError',
		warn  = 'DiagnosticFloatingWarn',
		info  = 'DiagnosticFloatingInfo',
		hint  = 'DiagnosticFloatingHint',
	}),
  MiniMap.gen_integration.diff(),
}

MiniMap.config.symbols.encode = MiniMap.gen_encode_symbols.dot('4x2')
MiniMap.config.window.width = 10
local utils = require('utils')
local map, L = utils.map, utils.L

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  callback = function()
    MiniMap.open()
  end,
})

map('n', L('um'), MiniMap.toggle, '[M]inimap Toggle')

map('n', L('us'), MiniMap.toggle_side, '[M]inimap Toggle Side')
