local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'

--- Use uv for later versions of Neovim
if not (vim.uv or vim.loop).fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.vim`" | redraw')
end
local H = {}
require('mini.deps').setup({ path = { package = path_package } })

--- @class MiniLoadSpec
--- @field source string
--- @field depends? string[]
--- @field hooks? table
--- @field later? boolean
--- @field cb? function
--- @field opts? table
--- @field name? string
--- @field disable? boolean
--- @param specs MiniLoadSpec[]
H.setup = function(specs)
  for _, spec in ipairs(specs) do
    if spec.disable then
      goto continue
    end
    local is_git = spec.source:find('/')
    local adaptive_func = spec.later and MiniDeps.later or MiniDeps.now
    adaptive_func(function()
      if is_git then
        MiniDeps.add({
          source = spec.source,
          depends = spec.depends,
          hooks = spec.hooks,
          name = spec.name,
        })
      else
        local mod = require(spec.source)
        if spec.opts then
          mod.setup(spec.opts)
        end
      end
      local cb = spec.cb or function() end
      local ok, err = pcall(cb)
      if not ok then
        print('Callback error:', err)
      end
    end)
    ::continue::
  end
end

return H
