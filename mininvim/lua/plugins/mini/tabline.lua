-- Things related to buffer or bufline
require('mini.tabline').setup({
  show_icon = true,
  format = function(buf_id, label)
		local parent = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf_id), ':h:t') or ''
    local default_format = MiniTabline.default_format(buf_id, parent .. '/' .. label)
    local suffix = vim.bo[buf_id].modified and '󰳻 ' or ''
    return default_format .. suffix
  end,
})

