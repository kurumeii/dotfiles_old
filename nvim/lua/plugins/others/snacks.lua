MiniDeps.add({
  source = 'folke/snacks.nvim',
})

require('snacks').setup({
  statuscolumn = {
    left = { 'mark' }, -- priority of signs on the left (high to low)
    right = { 'sign', 'fold' }, -- priority of signs on the right (high to low)
    git = {
      -- patterns to match Git signs
      patterns = { 'GitSign', 'MiniDiffSign' },
    },
    refresh = 50, -- refresh at most every 50ms
    folds = {
      open = true,
      git_hl = false,
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
  image = {
    enabled = true,
  },
  indent = {
    enabled = true,
  },
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.ui.input = Snacks.input.input

-- LSP rename from snacks to work with mini.files
vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniFilesActionRename',
	callback = function (e)
		Snacks.rename.on_rename_file(e.data.from, e.data.to)
	end
})
local util = require('utils')
local map, L = util.map, util.L

map('n', L('G'), function()
  Snacks.lazygit.open()
end, 'Open Lazy[G]it')

map('n', L('t'), Snacks.terminal.toggle, 'Toggle Terminal')
-- And rename file in current buffer
map('n', L('cr'), Snacks.rename.rename_file , '[C]ode [R]ename')

