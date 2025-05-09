local hi = require('mini.hipatterns')
local hi_words = MiniExtra.gen_highlighter.words
local util = require('utils')

hi.setup({
  highlighters = {
    fixme = hi_words({ 'FIXME', 'fixme' }, 'MiniHiPatternsFixme'),
    todo = hi_words({ 'TODO', 'todo' }, 'MiniHiPatternsTodo'),
    note = hi_words({ 'NOTE', 'note' }, 'MiniHiPatternsNote'),
    bug = hi_words({ 'BUG', 'bug', 'HACK', 'hack', 'hax' }, 'MiniHiPatternsHack'),
    hex_color = hi.gen_highlighter.hex_color({ priority = 200 }),
    hex_shorthand = {
      pattern = '()#%x%x%x()%f[^%x%w]',
      group = function(_, _, data)
        ---@type string
        local match = data.full_match
        local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
        local hex_color = '#' .. r .. r .. g .. g .. b .. b
        return hi.compute_hex_color_group(hex_color, 'bg')
      end,
    },
    hsl_color = {
      pattern = 'hsl%(%s*[%d%.]+%%?%s*[, ]%s*[%d%.]+%%?%s*[, ]%s*[%d%.]+%%?%s*%)',
      group = function(_, match)
        local h, s, l = match:match('([%d%.]+)%%?%s*[, ]%s*([%d%.]+)%%?%s*[, ]%s*([%d%.]+)%%?')
        h, s, l = tonumber(h), tonumber(s), tonumber(l)
        local hex = util.hslToHex(h, s, l)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    rgb_color = {
      pattern = 'rgb%(%d+,? %d+,? %d+%)',
      group = function(_, match)
        local r, g, b = match:match('rgb%((%d+),? (%d+),? (%d+)%)')
        r, g, b = tonumber(1), tonumber(2), tonumber(3)
        local hex = util.rgbToHex(r, g, b)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    rgba_color = {
      pattern = 'rgba%(%d+,? %d+,? %d+,? %d*%.?%d*%)',
      group = function(_, match)
        local r, g, b, a = match:match('rgba%((%d+),? (%d+),? (%d+),? (%d*%.?%d*)%)')
        r, g, b, a = tonumber(r), tonumber(g), tonumber(b), tonumber(a)
        if a == nil or a < 0 or a > 1 then
          return false
        end
        local hex = util.rgbToHex(r, g, b, a)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
    oklch_color = {
      pattern = 'oklch%(%s*[%d%.]+%s+[%d%.]+%s+[%d%.]+%s*/?%s*[%d%.]*%%?%s*%)',
      group = function(_, match)
        local l, c, h, a = match:match('oklch%(%s*([%d%.]+)%s+([%d%.]+)%s+([%d%.]+)%s*/?%s*([%d%.]*)%%?%s*%)')
        l, c, h = tonumber(l), tonumber(c), tonumber(h)
        if a == '' or a == nil then
          a = 1
        else
          a = tonumber(a)
          if a > 1 then
            a = a / 100
          end
        end
        local hex = util.oklchToHex(l, c, h, a)
        return hi.compute_hex_color_group(hex, 'bg')
      end,
    },
  },
})
