-- Things related to buffer or bufline
require('mini.tabline').setup({
  show_icon = true,
  tabpage_section = 'right',
  format = function(buf_id, label)
    local defualt_fm = MiniTabline.default_format(buf_id, label)
    local suffix = vim.bo[buf_id].modified and '󰳻 ' or ''
    return defualt_fm .. suffix
  end,
})

require('mini.bufremove').setup()

local utils = require('utils')
local map, L = utils.map, utils.L

map('n', L('bC'), function()
  local cur = vim.api.nvim_get_current_buf()
  local other_bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(other_bufs) do
    if buf ~= cur then
      MiniBufremove.delete(buf)
    end
  end
end, '[B]uffer [C]lose others')
map('n', L('bc'), function()
  MiniBufremove.delete(0)
end, '[B]uffer [C]lose')
