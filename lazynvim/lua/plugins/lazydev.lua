---@type LazySpec
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    dependencies = {
      { 'justinsgithub/wezterm-types', lazy = true },
    },
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
}
