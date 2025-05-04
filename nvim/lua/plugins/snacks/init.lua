require('snacks').setup({
  dashboard = {
    enabled = true,
    preset = {
      header = [[
 __       __ __          __ __     __ __              
|  \     /  \  \        |  \  \   |  \  \             
| ▓▓\   /  ▓▓\▓▓_______  \▓▓ ▓▓   | ▓▓\▓▓______ ____  
| ▓▓▓\ /  ▓▓▓  \       \|  \ ▓▓   | ▓▓  \      \    \ 
| ▓▓▓▓\  ▓▓▓▓ ▓▓ ▓▓▓▓▓▓▓\ ▓▓\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\
| ▓▓\▓▓ ▓▓ ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓
| ▓▓ \▓▓▓| ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓  \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓
| ▓▓  \▓ | ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓
 \▓▓      \▓▓\▓▓\▓▓   \▓▓\▓▓    \▓    \▓▓\▓▓  \▓▓  \▓▓
		]],
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        {
          icon = ' ',
          key = 'c',
          desc = 'Config',
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        {
          icon = ' ',
          key = 's',
          desc = 'Restore Session',
          action = function()
            local latest = MiniSessions.get_latest()
            if latest then
              MiniSessions.read(latest)
            end
          end,
        },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = { 2, 2 } },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 2 },
    },
  },
  statuscolumn = {
    left = { 'mark', 'git' }, -- priority of signs on the left (high to low)
    right = { 'sign', 'fold' }, -- priority of signs on the right (high to low)
    git = {
      -- patterns to match Git signs
      patterns = { 'MiniDiffSign' },
    },
    refresh = 50, -- refresh at most every 50ms
    folds = {
      open = true,
      git_hl = false,
    },
  },
  lazygit = { enabled = true },
  inputs = { enabled = true },
  bigfile = { enabled = true },
  terminal = { enabled = true },
  image = {
    enabled = true,
    force = true,
    env = {
    	['SNACKS_WEZTERM'] = 'true',
    }
  },
  indent = { enabled = true },
  bufdelete = { enable = true },
  picker = { enabled = true },
  quickfile = { enabled = true },
  notifier = {
    enabled = true,
    top_down = false,
    icons = {
      error = '',
      warn = '',
      info = '',
      debug = '',
    },
  },
  scope = { enabled = true },
  util = { enabled = true },
  words = { enabled = true },
})

vim.ui.input = Snacks.input.input
vim.ui.select = Snacks.picker.select
vim.notify = Snacks.notifier.notify

require('plugins.snacks.keymap')
require('plugins.snacks.autocmd')
