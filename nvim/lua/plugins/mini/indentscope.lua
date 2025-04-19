require('mini.indentscope').setup({
  symbol = '│',
  options = { try_as_border = true },
})

-- MiniIndentScope
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'dashboard',
    'Trouble',
    'trouble',
    'lazy',
    'mason',
    'notify',
    'toggleterm',
    'lazyterm',
  },
  desc = 'Disable indentscope in these filetypes',
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
