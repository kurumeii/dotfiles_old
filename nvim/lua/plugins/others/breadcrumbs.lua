local navic = require('nvim-navic')

navic.setup({
  highlight = true,
  depth_limit = 4,
  separator = ' ➜ ',
  depth_limit_indicator = '...',
})

vim.wo.winbar = string.format('%s', navic.get_location())
