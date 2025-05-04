local hi = require('mini.hipatterns')
local hi_words = MiniExtra.gen_highlighter.words
local util = require('utils')
hi.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHiPatternsFixme'),
    todo = hi_words({ 'TODO', 'todo' }, 'MiniHiPatternsTodo'),
    note = hi_words({ 'NOTE', 'note' }, 'MiniHiPatternsNote'),
    bug = hi_words({ 'BUG', 'bug' }, 'MiniHiPatternsHack'),
    hex_color = hi.gen_highlighter.hex_color({ priority = 200 }),
    hsl_color = {
      pattern = 'hsl%(%d+,? %d+,? %d+%)',
      group = function(_, match)
        local h, s, l = match:match('hsl%((%d+),? (%d+),? (%d+)%)')
        h, s, l = tonumber(h), tonumber(s), tonumber(l)
        local hex = util.hslToHex(h, s, l)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    rgb_color = {
      pattern = 'rgb%(%d+, ?%d+, ?%d+%)',
      group = function(_, match)
        local r, g, b = match:match('rgb%((%d+), ?(%d+), ?(%d+)%)')
        r, g, b = tonumber(r), tonumber(g), tonumber(b)
        local hex = util.rgbToHex(r, g, b)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    rgba_color = {
      pattern = 'rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)',
      group = function(_, match)
        local r, g, b, a = match:match('rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)')
        r, g, b, a = tonumber(r), tonumber(g), tonumber(b), tonumber(a)
        if a == nil or a < 0 or a > 1 then
          return false
        end
        local hex = util.rgbToHex(r, g, b, a)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    oklch_color = {
      pattern = '',
    },
  },
})
