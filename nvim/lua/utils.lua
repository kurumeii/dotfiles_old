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

return H
