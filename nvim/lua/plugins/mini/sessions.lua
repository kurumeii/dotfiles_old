require('mini.sessions').setup({
  autoread = false,
  autowrite = true,
  force = {
    delete = true,
  },
  directory = vim.fn.stdpath('data') .. '/sessions',
})

local utils = require('utils')
local map, L = utils.map, utils.L
local notify = utils.notify
-- Sessions

map({ 'n' }, L('Ss'), function()
  vim.ui.input({ prompt = 'Session name: ' }, function(input)
    if input == nil or input == '' then
      notify('Name is required for session', 'WARN')
      return
    end
    MiniSessions.write(input)
    notify('Session ' .. input .. ' saved', 'INFO')
  end)
end, 'Save session')

map({ 'n' }, L('Sd'), function()
  local ok, err = pcall(function()
    MiniSessions.select('delete')
    MiniSessions.read()
    notify('Session deleted', 'INFO')
  end)
  if not ok then
    notify('Error: ' .. tostring(err), 'ERROR')
  end
end, 'Delete session')

map({ 'n' }, L('Sl'), function()
  MiniSessions.select()
end, 'Load session')
