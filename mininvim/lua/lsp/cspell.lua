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

function H.add_word_to_right_place(dicts, word)
  if #dicts == 1 then
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

-- manually add code actions
function H.code_action() end

utils.map('n', utils.L('csw'), function()
  local opts = {
    prompt = 'Enter the word to add to the dictionary',
  }
  vim.ui.input(opts, function(word)
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
    else
      H.add_word_to_right_place(dicts, word)
    end
    vim.cmd('e!')
  end)
end, 'Code add word to dictionary')

utils.map('n', utils.L('csW'), function()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, cursor[1] - 1)
  local diagnostics_map = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.source == 'cspell' then
      table.insert(diagnostics_map, diagnostic)
    end
  end
  -- Get the first word from the first cspell diagnostic
  -- E.g. "Unknown word ( word )"
  local word = diagnostics_map[1].message:match('%((.+)%)')
  if not word then
    return
  end
  vim.ui.input({ prompt = 'Add ' .. word .. ' to dictionary ? y/n' }, function(input)
    if input:lower() == 'n' then
      return
    end

    local config = H.read_config(H.config_path())
    if not config then
      return
    end
    local dicts = config.dictionaryDefinitions or {}
    if #dicts == 0 then
      config.words = config.words or {}
      table.insert(config.words, word)
      H.write_config(config, H.config_path())
    else
      H.add_word_to_right_place(dicts, word)
    end
    vim.cmd('e!')
  end)
end, 'Code add diagnostic word to dictionary')
