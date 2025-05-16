local navic = require('nvim-navic')

navic.setup({
  highlight = true,
  depth_limit = 4,
  separator = ' ➜ ',
  depth_limit_indicator = '...',
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
