local miniclue = require('mini.clue')
miniclue.setup({
  window = {
    config = {
      -- width = 'auto',
      anchor = 'SW',
      row = 'auto',
      col = 'auto',
      -- width = vim.api.nvim_list_uis()[1]['width'],
      border = 'double',
    },
  },
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- `[]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- `\` key
    { mode = 'n', keys = [[\]] },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = '<C-w>' },
    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    { mode = 'n', keys = '<leader>b', desc = '[B]uffers ' },
    { mode = 'n', keys = '<leader>c', desc = '[C]ode ' },
    { mode = 'n', keys = '<leader>g', desc = '[G]it 󰊢' },
    { mode = 'n', keys = '<leader>f', desc = '[F]ind ' },
    { mode = 'n', keys = '<leader>w', desc = '[W]indow ' },
    { mode = 'n', keys = '<leader>wr', desc = '[W]indow [R]esize' },
    { mode = 'n', keys = '<leader>wq', desc = '[W]indow [Q]uit' },
    { mode = 'n', keys = '<leader>ws', desc = '[W]indow [S]plit' },
    { mode = 'n', keys = '<leader>n', desc = '[N]otify ' },
    { mode = 'n', keys = '<leader>l', desc = '[L]sp ' },
    { mode = 'n', keys = '<leader>d', desc = '[D]ebugger ' },
    { mode = 'n', keys = '<leader>S', desc = '[S]essions ' },
    { mode = 'n', keys = '<leader>u', desc = '[U]i ' },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows({
      submode_move = true,
      submode_navigate = true,
      submode_resize = true,
    }),
    miniclue.gen_clues.z(),
  },
})
