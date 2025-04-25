MiniDeps.add({
  source = 'folke/snacks.nvim',
})

require('snacks').setup({
  statuscolumn = {
    left = { 'mark' }, -- priority of signs on the left (high to low)
    right = { 'fold', 'sign' }, -- priority of signs on the right (high to low)
    git = {
      -- patterns to match Git signs
      patterns = { 'GitSign', 'MiniDiffSign' },
    },
    refresh = 50, -- refresh at most every 50ms
    folds = {
      open = true,
      git_hl = true,
    },
  },
  lazygit = {},
  inputs = {
    enabled = true,
  },
  bigfile = {
    enabled = true,
  },
  terminal = {
    enabled = true,
  },
})

-- vim.o.foldcolumn = 'auto:1'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.ui.input = Snacks.input.input

local util = require('utils')
local map, L = util.map, util.L

map('n', L('G'), function()
  Snacks.lazygit.open()
end, 'Open Lazy[G]it')

map('n', L('t'), Snacks.terminal.toggle, 'Toggle Terminal')
