MiniDeps.add({
  source = 'kevinhwang91/nvim-ufo',
  depends = {
    'kevinhwang91/promise-async',
    'luukvbaal/statuscol.nvim',
  },
})

local builtin = require('statuscol.builtin')
require('statuscol').setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc } },
    { text = { builtin.lnumfunc, ' ' } },
    { text = { '%s' } },
  },
})
local ufo = require('ufo')
ufo.setup({
  provider_selector = function()
    return {
      'treesitter',
      'indent',
    }
  end,
})
