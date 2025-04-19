MiniDeps.add({
  source = 'mfussenegger/nvim-lint',
})
local lint = require('lint')

lint.linters_by_ft = {
  markdown = { 'vale' },
  ['*'] = { 'cspell' },
  javascriptreact = {
    'biome',
  },
  typescriptreact = {
    'biome',
  },
  typescript = {
    'biome',
  },
  javascript = {
    'biome',
  },
}

local debounce = function(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    if timer ~= nil then
      timer:start(ms, 0, function()
        timer:stop()
        vim.schedule_wrap(fn)(unpack(argv))
      end)
    end
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = debounce(1000, function()
    local names = lint._resolve_linter_by_ft(vim.bo.filetype)
    names = vim.list_extend({}, names)
    -- Add fallback linters.
    if #names == 0 then
      vim.list_extend(names, lint.linters_by_ft['_'] or {})
    end
    -- Add global linters.
    vim.list_extend(names, lint.linters_by_ft['*'] or {})
    -- Filter out linters that don't exist or don't match the condition.
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      if not linter then
        MiniNotify.add('Linter not found: ' .. name, 'ERROR', 'nvim-lint')
      end
      return linter and not type(linter) == 'table'
    end, names)
    -- Run linters.
    if #names > 0 then
      lint.try_lint(names)
    end
  end),
})
