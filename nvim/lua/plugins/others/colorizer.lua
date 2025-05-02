MiniDeps.add({
  source = 'eero-lehtinen/oklch-color-picker.nvim',
})
local colorizer = require('oklch-color-picker')

colorizer.setup({
  highlight = {
    enabled = true,
    virtual_text = ' ',
    style = 'virtual_left',
		italic = true,
		emphasis = false -- set it to true when style are forground and background
  },
})

local utils = require('utils')

utils.map('n', utils.L 'cp', colorizer.pick_under_cursor, 'Pick color under cursor')
