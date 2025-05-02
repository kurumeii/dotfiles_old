require('mini.bufremove').setup()

local utils = require('utils')
local map, L = utils.map, utils.L

map('n', L('bc'), function()
  MiniBufremove.delete(0)
end, '[B]uffer Close current')
