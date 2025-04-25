local MiniAnimate = require('mini.animate')

MiniAnimate.setup({
  cursor = {
    enable = false,
  },
  scroll = {
    enable = true,
    timing = MiniAnimate.gen_timing.cubic({
      duration = 200,
      unit = 'total',
    }),
  },
  resize = { enable = false },
  open = { enable = true },
  close = { enable = true },
})
