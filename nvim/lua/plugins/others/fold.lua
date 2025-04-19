MiniDeps.add({
  source = 'kevinhwang91/nvim-ufo',
  depends = {
    'kevinhwang91/promise-async',
    -- 'luukvbaal/statuscol.nvim',
  },
})

require('ufo').setup({
  provider_selector = function()
    return {
      'treesitter',
      'indent',
    }
  end,
})
-- local builtin = require('statuscol.builtin')
-- require('statuscol').setup()
