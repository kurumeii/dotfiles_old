require('mini.bracketed').setup({
  treesitter = { suffix = '' },
})

local utils = require('utils')
local map, L = utils.map, utils.L

-- MiniBracketed/Buffer remap
--
map('n', 'L', function()
  MiniBracketed.buffer('forward')
end, 'Next buffer ->')
map('n', 'H', function()
  MiniBracketed.buffer('backward')
end, 'Previous buffer <-')
map('n', L('bl'), function()
  MiniBracketed.buffer('last')
end, '[B]uffer (L) ->>')
map('n', L('bh'), function()
  MiniBracketed.buffer('first')
end, '[B]uffer (H) <<-')
