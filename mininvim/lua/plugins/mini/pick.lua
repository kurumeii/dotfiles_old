require('mini.pick').setup({
  options = {
    content_from_bottom = false,
    use_cache = true,
  },
  -- window = {
  --   config = function()
  --     local height = math.floor(0.618 * vim.o.lines)
  --     local width = math.floor(0.618 * vim.o.columns)
  --     return {
  --       anchor = 'NW',
  --       height = height,
  --       width = width,
  --       row = math.floor(0.5 * (vim.o.lines - height)),
  --       col = math.floor(0.5 * (vim.o.columns - width)),
  --     }
  --   end,
  -- },
  mappings = {
    choose_in_vsplit = '<c-v>',
    move_up = '<S-tab>',
    move_down = '<tab>',
    mark = '',
    mark_all = '',
    toggle_preview = '<c-k>',
    toggle_info = '?',
  },
})
vim.ui.select = MiniPick.ui_select

-- Colorscheme picker =======================================================
-- Still waiting for the exact implementation from the author

local utils = require('utils')
local map, L = utils.map, utils.L

local function find_config_files()
  local dir = vim.fn.stdpath('config')
  local files = vim.fn.glob(dir .. '/**/*', true, true)
  files = vim.tbl_filter(function(f)
    return vim.fn.isdirectory(f) == 0
  end, files)
  files = vim.tbl_map(function(f)
    local file = vim.fn.fnamemodify(f, ':~:.')
    local icon = MiniIcons.get('file', file)
    return icon .. ' ' .. file
  end, files)
  MiniPick.start({
    source = {
      items = files,
      name = 'Config files',
    },
  })
end

map('n', L('fe'), MiniExtra.pickers.explorer, 'Find explorer')
map('n', L('ff'), MiniPick.builtin.files, 'Find files')
map('n', L('fw'), MiniPick.builtin.grep_live, 'Find word (Grep)')
map('n', L('fr'), MiniExtra.pickers.registers, 'Find registers')
map('n', L('fc'), MiniExtra.pickers.commands, 'Find commands')
map('n', L('fh'), MiniPick.builtin.help, 'Find help')
map('n', L('fk'), MiniExtra.pickers.keymaps, 'Find keymaps')
map('n', L('fb'), MiniPick.builtin.buffers, 'Find buffers')
map('n', L('fq'), function()
  MiniExtra.pickers.list({ scope = 'quickfix' })
end, 'Find quickfix list')
map('n', L('fC'), find_config_files, 'Find Config files')
map('n', L('fd'), function()
  MiniExtra.pickers.diagnostic({ scope = 'current' })
end, 'Find Diagnostics in buffer')
map('n', L('fD'), function()
  MiniExtra.pickers.diagnostic({ scope = 'all' })
end, 'Find Diagnostics')
map('n', L('fm'), MiniExtra.pickers.marks, 'Find marks')
map('n', L('fH'), MiniExtra.pickers.history, 'Find history')
map('n', L('fv'), MiniExtra.pickers.visit_paths, 'Find visit paths')
map('n', L('fV'), MiniExtra.pickers.visit_labels, 'Find visit labels')
map('n', L('css'), MiniExtra.pickers.spellsuggest, 'Code spelling suggestions')
-- LSP =======================================================================
map('n', L('lr'), function()
  MiniExtra.pickers.lsp({ scope = 'references' })
end, 'LSP references')
map('n', L('ld'), function()
  MiniExtra.pickers.lsp({ scope = 'definition' })
end, 'LSP definitions')
map('n', L('lt'), function()
  MiniExtra.pickers.lsp({ scope = 'type_definition' })
end, 'LSP type definitions')
map('n', L('li'), function()
  MiniExtra.pickers.lsp({ scope = 'implementation' })
end, 'LSP implementations')
map('n', L('lD'), function()
  MiniExtra.pickers.lsp({ scope = 'declaration' })
end, 'LSP declarations')
map('n', L('ls'), function()
  MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end, 'LSP symbols')
map('n', L('lS'), function()
  MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })
end, 'LSP workspace symbols')
-- Git =======================================================================
map('n', L('gb'), function()
  MiniExtra.pickers.git_branches({ scope = 'local' })
end, 'List local git branches')
map('n', L('gB'), function()
  MiniExtra.pickers.git_branches({ scope = 'remotes' })
end, 'List remote git branches')
map('n', L('gc'), function()
  MiniExtra.pickers.git_commits({
    path = vim.fn.expand('%'),
  })
end, 'List git commit for current file')
map('n', L('gC'), MiniExtra.pickers.git_commits, 'List all git commits')
map('n', L('gh'), MiniExtra.pickers.git_hunks, 'List unstaged git hunks')
map('n', L('gH'), function()
  MiniExtra.pickers.git_hunks({ scope = 'staged' })
end, 'List staged git hunks')
