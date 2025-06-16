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
require('mini.deps').setup({ path = { package = path_package } })

local H = {}

---@param lazy boolean
---@param cb function
local adaptive_func = function(lazy, cb)
  return lazy and MiniDeps.later(cb) or MiniDeps.now(cb)
end

---@param specs MiniLoadSpec
local load = function(specs)
  if specs.disable then
    return
  end
  local is_git = specs.source:find('/') ~= nil
  local get_mod_name = function()
    if is_git then
      return specs.name or specs.source:match('.*/(.*)')
    else
      return specs.source
    end
  end
  local after_script = function()
    local mod_name = get_mod_name()
    if specs.cb then
      local ok, err = pcall(specs.cb)
      if not ok then
        vim.notify('Callback error in: ' .. specs.source .. '\n\t' .. tostring(err), vim.log.levels.ERROR)
      end
    elseif specs.opts then
      require(mod_name).setup(specs.opts)
    else
      require(mod_name)
    end
  end
  return adaptive_func(specs.lazy, function()
    if is_git then
      MiniDeps.add(specs)
      after_script()
    else
      after_script()
    end
  end)
end

--- @param specs MiniLoadSpec[]
H.setup = function(specs)
  for _, spec in pairs(specs) do
    load(spec)
  end
end

return H

-- H.setup = function(specs)
--   for _, spec in pairs(specs) do
--     if spec.disable then
--       goto continue
--     end
--     local is_git = spec.source:find('/') ~= nil
--     local get_mod_name = function()
--       if is_git then
--         return spec.name or spec.source:match('.*/(.*)')
--       end
--       return spec.source
--     end
--
--     H.adaptive_func(spec.later, function()
--       local mod_name = get_mod_name()
--       if is_git then
--         MiniDeps.add({
--           source = spec.source,
--           depends = spec.depends,
--           hooks = spec.hooks,
--           name = spec.name,
--         })
--       end
--       if spec.cb then
--         local ok, err = pcall(spec.cb)
--         if not ok then
--           vim.notify('Callback error in: ' .. mod_name .. '\n\t' .. tostring(err), vim.log.levels.ERROR)
--         end
--       elseif spec.opts then
--         require(mod_name).setup(spec.opts)
--       else
--         require(mod_name)
--       end
--     end)
--     ::continue::
--   end
-- end

-- return H
