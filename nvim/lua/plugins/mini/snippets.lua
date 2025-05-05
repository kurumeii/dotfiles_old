local snippets = require('mini.snippets')
snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang(),
  },
  expand = {
    select = function(snip, ins)
      local select = snippets.default_select
      select(snip, ins)
    end,
  },
})
