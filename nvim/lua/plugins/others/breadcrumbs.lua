local barbecue = require('barbecue.ui')

require('barbecue').setup({
  attach_navic = false, -- For multiple tab
  create_autocmd = false, -- Better perfomance
  context_follow_icon_color = true,
  theme = 'auto',
  kinds = {
    File = '󰈙 ',
    Module = ' ',
    Namespace = '󰌗 ',
    Package = ' ',
    Class = '󰌗 ',
    Method = '󰆧 ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = '󰕘',
    Interface = '󰕘',
    Function = '󰊕 ',
    Variable = '󰆧 ',
    Constant = '󰏿 ',
    String = '󰀬 ',
    Number = '󰎠 ',
    Boolean = '◩ ',
    Array = '󰅪 ',
    Object = '󰅩 ',
    Key = '󰌋 ',
    Null = '󰟢 ',
    EnumMember = ' ',
    Struct = '󰌗 ',
    Event = ' ',
    Operator = '󰆕 ',
    TypeParameter = '󰊄 ',
  },
})

vim.api.nvim_create_autocmd({
  'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
  'BufWinEnter',
  'CursorHold',
  'InsertLeave',
  -- include this if you have set `show_modified` to `true`
  'BufModifiedSet',
}, {
  group = vim.api.nvim_create_augroup('barbecue.updater', {}),
  callback = function()
    barbecue.update()
  end,
})

--- Keymap
local utils = require('utils')
utils.map('n', utils.L('ub'), barbecue.toggle, 'UI Toggle breadcrumbs')
