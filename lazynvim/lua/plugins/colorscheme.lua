---@type LazySpec
return {
  {
    'ellisonleao/gruvbox.nvim',
    opts = {
      dim_inactive = true,
    },
  },
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
      colorscheme = 'catppuccin',
    },
  },
}
