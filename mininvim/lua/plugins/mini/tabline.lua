require('mini.tabline').setup({
  show_icon = true,
  format = function(buf_id, label)
    local buf_name = vim.api.nvim_buf_get_name(buf_id)
    local icon = vim.bo[buf_id].modified and mininvim.icons.edit or MiniIcons.get('file', buf_name)
    return string.format(' %s %s ', label, icon)
  end,
})

local utils = require('utils')

utils.map('n', utils.L('bd'), MiniBufremove.delete, 'Budder delete')
utils.map('n', utils.L('bo'), function()
  local buffers = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  for _, buf_id in ipairs(buffers) do
    if vim.bo[buf_id].buflisted and buf_id ~= current then
      MiniBufremove.delete(buf_id)
    end
  end
end, 'Buffer delete other')

utils.map('n', utils.L('bD'), function()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf_id in ipairs(buffers) do
    if vim.bo[buf_id].buflisted then
      MiniBufremove.delete(buf_id)
    end
  end
end, 'Buffer delete all')
