require('mini.pick').setup({
  options = {
    content_from_bottom = false,
    use_cache = true,
  },
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
  mappings = {
    choose_in_vsplit = '<c-L>',
  },
})
vim.ui.select = MiniPick.ui_select
