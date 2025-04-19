require('mini.completion').setup({
  mappings = {
    force_twostep = '<C-Space>',
    force_fallback = '<A-Space>',
    scroll_down = '<C-U>',
    scroll_up = '<C-D>',
  },
})
MiniIcons.tweak_lsp_kind()

local utils = require('utils')
local map = utils.map

map(
  { 'i' },
  '<cr>',
  function()
    if vim.fn.pumvisible() ~= 0 then
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and vim.keycode('<c-y>') or vim.keycode('<c-y><cr>')
    end
    return MiniPairs.cr()
  end,
  'Accept completion',
  {
    expr = true,
  }
)
