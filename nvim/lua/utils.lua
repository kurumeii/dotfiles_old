local H = {}
H.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end

H.L = function(key)
  return '<leader>' .. key
end
H.C = function(cmd)
  return '<cmd>' .. cmd .. '<cr>'
end

--- @param msg string
--- @param level 'ERROR' | 'WARN' | 'INFO'
--- @param timeout number?
H.notify = function(msg, level, timeout)
  level = level or 'INFO'
  timeout = timeout or 2000
  -- local id = require('mini.notify').add(msg, level)
    vim.defer_fn(function()
			Snacks.notify[string.lower(level)](msg)
      -- require('mini.notify').remove(id)
    end, timeout)
end

return H
