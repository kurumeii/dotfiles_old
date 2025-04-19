local ai = require('mini.ai')
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    L = require('mini.extra').gen_ai_spec.line(), -- Line
    F = ai.gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner',
    }), -- Function
  },
})
