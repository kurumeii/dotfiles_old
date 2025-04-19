MiniDeps.add({
  source = 'catppuccin/nvim',
  name = 'catppuccin',
})
require('catppuccin').setup({
  flavor = 'latte',
  -- background = {
  --   light = 'latte',
  --   dark = 'mocha',
  -- },
  transparent_background = true,
  term_colors = true,
  dim_inactive = {
    enable = true,
    shade = 'dark',
    percentage = 0.15,
  },
})
