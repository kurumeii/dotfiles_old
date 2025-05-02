-- Things related to buffer or bufline
require('mini.tabline').setup({
  show_icon = true,
  format = function(buf_id, label)
    local defualt_fm = MiniTabline.default_format(buf_id, label)
    local suffix = vim.bo[buf_id].modified and '󰳻 ' or ''
    return defualt_fm .. suffix
  end,
})

