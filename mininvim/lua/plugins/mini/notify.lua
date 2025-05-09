require('mini.notify').setup({
  content = {
    format = function(notif)
      if notif.data.source == 'lsp_progress' then
        return notif.msg
      end
      return MiniNotify.default_format(notif)
    end,
    sort = function(notif_arr)
      table.sort(notif_arr, function(a, b)
        return a.ts_update > b.ts_update
      end)
      return notif_arr
    end,
  },
  window = {
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
      return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
    end,
  },
  lsp_progress = {
    enable = true,
    duration_last = 2000,
  },
})

vim.notify = MiniNotify.make_notify()

local utils = require('utils')
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path ~= '' then
      path = vim.fn.fnamemodify(path, ':~:.')
    end
    vim.notify('Saved ' .. vim.inspect(path))
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.fn.getreg('"') then
      local number_of_lines = vim.fn.getreg('"'):len()
      utils.notify('Yanked ' .. number_of_lines .. ' lines', 'INFO')
    end
  end,
})

utils.map('n', utils.L('nd'), MiniNotify.clear, '[N]otify: [D]ismiss all')
