local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    L = MiniExtra.gen_ai_spec.line(), -- Line
    F = ai.gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }), -- Function
    o = ai.gen_spec.treesitter({
      a = { '@block.outer', '@loop.outer', '@conditional.outer' },
      i = { '@block.inner', '@loop.inner', '@conditional.inner' },
    }),
    B = MiniExtra.gen_ai_spec.buffer(),
    D = MiniExtra.gen_ai_spec.diagnostic(),
    I = MiniExtra.gen_ai_spec.indent(),
    N = MiniExtra.gen_ai_spec.number(),
  },
})
