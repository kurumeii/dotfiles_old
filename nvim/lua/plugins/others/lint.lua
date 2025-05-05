local lint = require('lint')
local utils = require('utils')
lint.linters_by_ft = {
  ['*'] = { 'cspell' },
  lua = { 'selene', 'cspell' },
  markdown = { 'markdownlint-cli2', 'cspell' },
  javascriptreact = { 'biome' },
  typescriptreact = { 'biome' },
  typescript = { 'biome' },
  javascript = { 'biome' },
}

-- lint.linters.cspell = require('lint.util').wrap(lint.linters.cspell, function(dig)
--   dig.severity = vim.diagnostic.severity.HINT
--   return dig
-- end)

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = utils.debounce(100, function()
    local names = lint._resolve_linter_by_ft(vim.bo.ft)
    -- create a copy w/o modified the original
    names = vim.list_extend({}, names)
    -- Fallback
    if #names == 0 then
      vim.list_extend(names, lint.linters_by_ft['_'] or {})
    end
    -- use global
    vim.list_extend(names, lint.linters_by_ft['*'] or {})
    -- Filter out linters that don't exists or don't match the cond
    local buf_name = vim.api.nvim_buf_get_name(0)
    local ctx = { filename = buf_name, dirname = vim.fn.fnamemodify(buf_name, ':h') }
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      if not linter then
        utils.notify('Linter not found: ' .. name, 'ERROR')
      end
      return linter and not type(linter) == 'table' and linter.condition and not linter.condition(ctx)
    end, names)

    if #names > 0 then
      lint.try_lint(names)
    end
  end),
})
