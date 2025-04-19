require('mini.notify').setup({
  winblend = 95,
  lsp_progress = {
    enabled = true,
    duration_last = 1000,
  },
})

vim.notify = MiniNotify.make_notify()

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path ~= '' then
      path = vim.fn.fnamemodify(path, ':~:.')
    end
    vim.notify('Saved ' .. vim.inspect(path))
  end,
})
