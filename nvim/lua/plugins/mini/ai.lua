local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    l = require('mini.extra').gen_ai_spec.line(), -- Line
    f = ai.gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }), -- Function
    o = ai.gen_spec.treesitter({ -- code block
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
  },
})
