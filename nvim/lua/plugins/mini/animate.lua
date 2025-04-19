local MiniAnimate = require('mini.animate')

MiniAnimate.setup({
  cursor = {
    enable = true,
    timing = MiniAnimate.gen_timing.cubic({
      duration = 100,
      unit = 'total',
    }),
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
