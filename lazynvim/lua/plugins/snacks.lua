---@type LazySpec
return {
  {
    'folke/snacks.nvim',
    opts = {
      scratch = { enabled = false },
      picker = {
        sources = {
          explorer = {
            layout = {
              preset = 'sidebar',
              preview = true,
              layout = { position = 'right' },
            },
            ignored = true,
            hidden = true,
          },
        },
      },
    },
  },
}
