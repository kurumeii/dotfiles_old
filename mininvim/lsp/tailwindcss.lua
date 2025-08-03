local opts = {
  excludes = { 'markdown' },
  includes = {},
  --- uncomment to fully override the default filetypes
  -- filetypes = {}
}

local tw = require('lspconfig.configs.tailwindcss')
opts.filetypes = opts.filetypes or {}

vim.list_extend(opts.filetypes, tw.default_config.filetypes)

opts.filetypes = vim.tbl_filter(function(ft)
  return not vim.tbl_contains(opts.excludes or {}, ft)
end, opts.filetypes)

vim.list_extend(opts.filetypes, opts.includes or {})
opts.settings = {
  tailwindCSS = {
    classFunctions = { 'cva', 'cx', 'tv' },
  },
}
return opts
