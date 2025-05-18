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

--- @param specs MiniLoadSpec[]
H.setup = function(specs)
  for _, spec in pairs(specs) do
    if spec.disable then
      goto continue
    end
    local is_git = spec.source:find('/')
    local adaptive_func = spec.later and MiniDeps.later or MiniDeps.now
    local get_mod_name = function()
      if is_git then
        return spec.name or spec.source:match('/(.*)')
      end
      return spec.source
    end
    adaptive_func(function()
      local mod_name = get_mod_name()
      if is_git then
        MiniDeps.add({
          source = spec.source,
          depends = spec.depends,
          hooks = spec.hooks,
          name = spec.name,
        })
      end
      local cb = spec.cb or function()
        require(mod_name).setup(spec.opts)
      end
      pcall(cb)
    end)
    ::continue::
  end
end

return H
