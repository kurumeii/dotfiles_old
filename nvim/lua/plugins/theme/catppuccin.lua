MiniDeps.add({
  source = 'catppuccin/nvim',
  name = 'catppuccin',
})
require('catppuccin').setup({
  flavor = 'auto',
  background = {
    light = 'latte',
    dark = 'macchiato',
  },
  transparent_background = false,
  term_colors = true,
  dim_inactive = {
    enable = true,
    shade = 'dark',
    percentage = 0.15,
  },
})
