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
  if type(spec) == 'string' then
    adaptive_func(function()
      require(spec)
      cb()
    end)
  else
    adaptive_func(function()
      pcall(add)
    end)
  end
end

-- -----------------------------------------------------------------------------
-- Mini plugins
load('plugins.mini.notify', 'now')
load('plugins.theme', 'now')
load('plugins.mini.icons', 'now')
load('plugins.mini.basics', 'now')
load('plugins.mini.starter', 'now')
load('plugins.mini.files', 'now')
load('plugins.mini.clues', 'now')
-- Pretty bonkers
load('plugins.mini.animate', 'later')
load('mini.bracketed', 'later', function()
  require('mini.bracketed').setup()
end)
load('mini.surround', 'later', function()
  require('mini.surround').setup()
end)
load('mini.jump', 'later', function()
  require('mini.jump').setup()
end)
load('mini.pairs', 'later', function()
  require('mini.pairs').setup()
end)
load('mini.bufremove', 'later', function()
  require('mini.bufremove').setup()
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
load('mini.statusline', 'later', function()
  require('mini.statusline').setup()
end)
load('plugins.mini.tabline', 'later')
load('plugins.mini.snippets', 'later')
load('plugins.mini.jump2d', 'later')
load('plugins.mini.pick', 'later')
load('plugins.mini.diff', 'later')
load('plugins.mini.ai', 'later')
load('plugins.mini.indentscope', 'later')
load('plugins.mini.completion', 'later')
load('plugins.mini.hipatterns', 'later')
-- Another plugins
load(add('nvim-lua/plenary.nvim'), 'later')
load('plugins.others.better-escape', 'later')
load('plugins.others.treesitter', 'later')
-- load('plugins.others.blink-cmp', 'later')
load('plugins.others.lsp', 'later')
load(add('themaxmarchuk/tailwindcss-colors.nvim'), 'later')
load(add('justinsgithub/wezterm-types'), 'later')
load('plugins.others.conform', 'later')
load('plugins.others.fold', 'later')
load('plugins.others.supermaven', 'later')
load('plugins.others.lint', 'later')
load('plugins.others.debugger', 'later')

load('config.keymap', 'now')
load('config.option', 'now')
