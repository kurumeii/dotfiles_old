local miniclue = require('mini.clue')
miniclue.setup({
  window = {
    config = {
      width = 'auto',
      anchor = 'SE',
      -- relative = 'editor',
      -- width = vim.api.nvim_list_uis()[1]['width'],
      -- row = 'auto',
      -- col = 'auto',
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
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    { mode = 'n', keys = '<leader>b', desc = '[B]uffers ' },
    { mode = 'n', keys = '<leader>c', desc = '[C]ode ' },
    { mode = 'n', keys = '<leader>s', desc = '[S]earch ' },
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
    -- miniclue.gen_clues.g(),
    -- miniclue.gen_clues.marks(),
    miniclue.gen_clues.z(),
  },
})
