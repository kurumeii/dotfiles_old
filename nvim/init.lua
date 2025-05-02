require('config.mini')
-- Utilities ==================================================================
-- -----------------------------------------------------------------------------

--- @param path string -- The repository source path
--- @param opts? table -- Mini.Deps add options
local add = function(path, opts)
  opts = opts or {}
  return function()
    MiniDeps.add(vim.tbl_extend('force', {
      source = path,
    }, opts))
  end
end

--- @param spec string|function
--- @param mode 'now'|'later'
--- @param cb? function
local load = function(spec, mode, cb)
  cb = cb or function() end
  local adaptive_func = mode == 'later' and MiniDeps.later or MiniDeps.now
  adaptive_func(function()
    (type(spec) == 'string' and require or pcall)(spec)
    cb()
  end)
end

-- ============================================================================
load('config.option', 'now')

-- Mini plugins
load('plugins.mini.notify', 'now')
load('plugins.theme', 'now')
load('plugins.mini.icons', 'now')
load('plugins.mini.basics', 'now')
load('plugins.mini.starter', 'now')
load('plugins.mini.sessions', 'now')

-- Pretty bonkers
load('plugins.mini.animate', 'later')
load('plugins.mini.bracketed', 'later')
load('mini.surround', 'later', function()
  require('mini.surround').setup()
end)
load('mini.jump', 'later', function()
  require('mini.jump').setup()
end)
load('mini.pairs', 'later', function()
  require('mini.pairs').setup()
end)
load('mini.cursorword', 'later', function()
  require('mini.cursorword').setup()
end)
load('mini.trailspace', 'later', function()
  require('mini.trailspace').setup()
end)
load('mini.fuzzy', 'later', function()
  require('mini.fuzzy').setup()
end)
load('mini.extra', 'later', function()
  require('mini.extra').setup()
end)
load('mini.operators', 'later', function()
  require('mini.operators').setup()
end)
load('mini.comment', 'later', function()
  require('mini.comment').setup()
end)
load('plugins.mini.bufremove', 'later')
load('plugins.mini.statusline', 'now')
load('plugins.mini.tabline', 'later')
load('plugins.mini.snippets', 'later')
load('plugins.mini.jump2d', 'later')
load('plugins.mini.pick', 'later')
load('plugins.mini.diff', 'later')
load('plugins.mini.ai', 'later')
load('plugins.mini.indentscope', 'later')
load('plugins.mini.completion', 'later')
load('plugins.mini.hipatterns', 'later')
load('plugins.mini.minimap', 'later')
load('plugins.mini.files', 'later')
load('plugins.mini.clues', 'later')
load('plugins.mini.visited', 'later')
-- ============================================================================
-- Another plugins
load(add('nvim-lua/plenary.nvim'), 'later')
load('plugins.others.treesitter', 'later')
load(add('max397574/better-escape.nvim'), 'later', function()
  require('better_escape').setup()
end)
-- load('plugins.others.blink-cmp', 'later')
load(add('themaxmarchuk/tailwindcss-colors.nvim'), 'later', function()
  require('tailwindcss-colors').setup()
end)
load(add('windwp/nvim-ts-autotag'), 'later', function()
  require('nvim-ts-autotag').setup()
end)
load(add('TheLeoP/powershell.nvim'), 'later', function()
  require('powershell').setup({
    bundle_path = vim.fn.stdpath('data')
      .. '/mason/packages/powershell-editor-services',
  })
end)
load('plugins.others.lsp', 'later')
load('plugins.others.conform', 'later')
load('plugins.others.snacks', 'later')
load('plugins.others.fold', 'later')
load('plugins.others.supermaven', 'later')
load('plugins.others.lint', 'later')
load('plugins.others.debugger', 'later')
load('plugins.others.colorizer', 'later')

load('config.keymap', 'now')
