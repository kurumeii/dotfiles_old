local lint = require('lint')
local utils = require('utils')
local config_path = vim.fn.getcwd() .. '\\cspell.config.yaml'
lint.linters.cspell = function()
  local default_config = require('lint.linters.cspell')
  local config = vim.deepcopy(default_config)
  config.args = {
    'lint',
    '--no-color',
    '--no-progress',
    '--no-summary',
    '--config',
    config_path,
    function()
      return 'stdin://' .. vim.api.nvim_buf_get_name(0)
    end,
  }
  return config
end

utils.map('n', utils.L('csd'), function() end, 'Code add config file')

utils.map('n', utils.L('csw'), function()
  local buffer = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1

  local diags = vim.diagnostic.get(buffer, { lnum = line })
  if #diags == 0 then
    return
  end

  local word
  for _, diag in ipairs(diags) do
    if diag.source == 'cspell' then
      word = diag.message:match('%(([^)]+)%)')
      if not word then
        word = vim.fn.expand('<cword>')
      end
      break
    end
  end
  if not word then
    return
  end
  local file = io.open(config_path, 'a')
  if file then
    file:write(word .. '\n')
    file:close()
    utils.notify("Added '" .. word .. "' to cspell.words.txt")
  else
    utils.notify('Could not open cspell.words.txt')
  end
end, 'Code add word to dictionary')
