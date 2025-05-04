require('mini.diff').setup({
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    style = 'sign',
    signs = {
      add = '▎',
      change = '▎',
      delete = '',
    },
  },
})
