---@type LazySpec
return {
  -- add gruvbox
  'ellisonleao/gruvbox.nvim',
  {
    'rebelot/kanagawa.nvim',
    opts = {
      compile = true,
      transparent = false,
      dimInactive = true,
      background = {
        light = 'lotus',
        dark = 'wave',
      },
    },
  },
  {
    'AstroNvim/astrotheme',
    opts = {
      palette = 'astrodark',
    },
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'astrotheme',
    },
  },
}
