local grug = require('grug-far')
grug.setup({
  headerMaxWidth = 80,
  engine = 'astgrep',
  transient = true,
})

local utils = require('utils')

utils.map({ 'n', 'v' }, utils.L('sg'), function()
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  grug.open({
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  })
end, 'Search and grug')
