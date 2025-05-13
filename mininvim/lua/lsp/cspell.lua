local lint = require('lint')
local utils = require('utils')
local valid_config_file = {
  '.cspell.json',
  '.cspell.yaml',
  '.cspell.yml',
  '.cspell.jsonc',
  '.cspell.config.yaml',
  '.cspell.config.yml',
  'cspell.json',
  'cspell.yaml',
  'cspell.yml',
  'cspell.jsonc',
  'cspell.config.yaml',
  'cspell.config.yml',
}
local H = {}

H.config_path = function()
  for idx, config_file in pairs(valid_config_file) do
    local path = vim.fn.getcwd() .. '/' .. config_file ---@type string
    if vim.uv.fs_stat(path) then
      return path
    elseif idx == #valid_config_file then
      utils.notify('Config file not found', 'WARN')
    end
  end
end

---@param file string
function H.read_config(file)
  local lines = vim.fn.readfile(file)
  local ext = file:match('^.+(%..+)$')
  if ext == '.json' then
    return vim.json.decode(table.concat(lines, '\n'))
  elseif ext == '.yaml' or ext == '.yml' then
    utils.notify('Only support for json file right now', 'WARN')
    return nil
  else
    utils.notify('Unsupported file type', 'ERROR')
    return nil
  end
end

function H.write_config(content, cfg_path)
  local fd = io.open(cfg_path, 'w')
  if not fd then
    return
  end
  fd:write(vim.json.encode(content))
  fd:close()
end

function H.append_word(dict_path, word)
  local fd = io.open(dict_path, 'a+')
  if not fd then
    return
  end
  fd:write(word .. '\n')
  fd:close()
end

lint.linters.cspell = function()
  local default_config = require('lint.linters.cspell')
  local config = vim.deepcopy(default_config)
  config.args = {
    'lint',
    '--no-color',
    '--no-progress',
    '--no-summary',
    type(H.config_path()) == 'string' and '--config=' .. H.config_path() or '',
    function()
      return 'stdin://' .. vim.api.nvim_buf_get_name(0)
    end,
  }
  return config
end

utils.map('n', utils.L('csa'), function()
  local items = { '.yml', '.json' }
  local opts = {
    prompt = 'Choose a cspell config file',
    format_item = function(item)
      return 'Create cspell' .. item
    end,
  }

  ---@param choice string
  local function on_choice(choice)
    if not choice then
      return utils.notify('Hey you cancel the thingy', 'INFO')
    end
    local fname = 'cspell' .. choice
    local content = ''
    if choice == '.yaml' then
      content = [[
version: "0.2"
language: "en"
words: []
]]
    else
      content = [[
{
	"$schema": "https://raw.githubusercontent.com/streetsidesoftware/cspell/main/cspell.schema.json",
  "version": "0.2",
  "language": "en",
  "words": []
}
]]
    end
    local file = io.open(fname, 'w')
    if not file then
      return utils.notify('Can not write file', 'ERROR')
    else
      file:write(content)
      file:close()
      utils.notify('Created ' .. fname)
    end
  end
  vim.ui.select(items, opts, on_choice)
end, 'Code add config file')

utils.map('n', utils.L('csw'), function()
  local opts = {
    prompt = 'Enter the word to add to the dictionary',
  }
  local function on_confirm(word)
    if not word or word == '' then
      return utils.notify('Cancelled input', 'WARN')
    end
    local config_file = H.config_path()
    if not config_file then
      return
    end
    -- Read config file
    -- TODO: Only support json file for now
    local config = H.read_config(config_file)
    if not config then
      return
    end

    -- Find dictionary
    local dicts = config.dictionaryDefinitions or {}

    -- Add word to right place
    if #dicts == 0 then
      config.words = config.words or {}
      table.insert(config.words, word)
      H.write_config(config, config_file)
    elseif #dicts == 1 then
      local dict_path = dicts[1].path
      H.append_word(dict_path, word)
    else
      vim.ui.select(dicts, { prompt = 'Select dictionary: ' }, function(d, idx)
        if not d then
          return
        end
        local current_dict = dicts[idx]
        H.append_word(current_dict.path, word)
      end)
    end
  end
  vim.cmd('e!')
  vim.ui.input(opts, on_confirm)
end, 'Code add word to dictionary')
