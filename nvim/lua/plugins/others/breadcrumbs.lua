MiniDeps.add({
  source = 'SmiteshP/nvim-navic',
  depends = {
    'neovim/nvim-lspconfig',
  },
})

local navic = require('nvim-navic')

navic.setup({
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
	highlight = true,
	separator = " > ",
	depth_limit = 5,
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 10000 then
      vim.b.navic_lazy_update_context = true
    end
  end,
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
