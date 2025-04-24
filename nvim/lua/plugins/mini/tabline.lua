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

map('n', L('bo'), function()
  local cur = vim.api.nvim_get_current_buf()
  local other_bufs = vim.api.nvim_list_bufs()
  for _, buf in pairs(other_bufs) do
    if buf ~= cur then
      MiniBufremove.delete(buf)
    end
  end
end, '[B]uffer Close Others')
map('n', L('bc'), function()
  MiniBufremove.delete(0)
end, '[B]uffer Close current')

map('n', L('bC'), function()
  vim.ui.select({ 'yes', 'no' }, {
    prompt = 'Are you sure you want to close all buffers?',
  }, function(choice)
    local all = vim.api.nvim_list_bufs()
    if choice == 'yes' then
			for _, buf in pairs(all) do
				MiniBufremove.wipeout(buf)
			end
    end
  end)
end, '[B]uffer Close all')
