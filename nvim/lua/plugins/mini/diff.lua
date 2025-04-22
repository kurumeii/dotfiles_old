require('mini.diff').setup({
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    style = 'number',
    signs = {
      add = '▎',
      change = '▎',
      delete = '',
    },
  },
})
