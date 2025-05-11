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

utils.map('n', utils.L('csw'), function() end, 'Code add word to dictionary')
