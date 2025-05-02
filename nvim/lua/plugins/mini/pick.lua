require('mini.pick').setup({
  options = {
    content_from_bottom = false,
    use_cache = true,
  },
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
  mappings = {
    choose_in_vsplit = '<c-L>',
  },
})
vim.ui.select = MiniPick.ui_select

local utils = require('utils')
local map, L = utils.map, utils.L

-- MiniPick/ Picker
map('n', L('sf'), function()
  MiniPick.builtin.files()
end, '[S]earch [F]iles')
map('n', L('sw'), function()
  MiniPick.builtin.grep_live()
end, '[S]earch [W]ord')
map('n', L('st'), function()
  vim.cmd('Pick colorschemes')
end, '[S]earch [T]heme')
map('n', L('sr'), function()
  vim.cmd('Pick registers')
end, '[S]earch [R]egistry')
map('n', L('sc'), function()
  vim.cmd('Pick commands')
end, '[S]earch [C]ommands')
map('n', L('sh'), function()
  MiniPick.builtin.help()
end, '[S]earch [H]elp')
map('n', L('sb'), function()
  MiniPick.builtin.buffers()
end, '[S]earch [B]uffer')

-- LSP
map('n', L('lr'), function()
  vim.cmd('Pick lsp scope="references"')
end, '[L]sp: [R]efrences')
map('n', L('ld'), function()
  vim.cmd('Pick lsp scope="definition"')
end, '[L]sp: [D]efinition')
map('n', L('lD'), function()
  vim.cmd('Pick lsp scope="declaration"')
end, '[L]sp: [D]eclaration')
map('n', L('li'), function()
  vim.cmd('Pick lsp scope ="implementation"')
end, '[L]sp: [I]mplementation')
