require('snacks').setup({
  dashboard = {
    enabled = false,
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
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('')})",
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
    },
  },
  statuscolumn = {
    left = { 'mark', 'fold' }, -- priority of signs on the left (high to low)
    right = { 'sign', 'git' }, -- priority of signs on the right (high to low)
    git = {
      -- patterns to match Git signs
      patterns = { 'MiniDiffSign' },
    },
    refresh = 50, -- refresh at most every 50ms
    folds = {
      open = true,
      git_hl = true,
    },
  },
  lazygit = { enabled = true },
  gitbrowse = { enabled = true },
  inputs = { enabled = true },
  bigfile = { enabled = true },
  terminal = { enabled = true },
  image = {
    enabled = true,
    force = true,
    env = {
      ['SNACKS_WEZTERM'] = 'true',
    },
  },
  indent = { enabled = false, scope = false },
  bufdelete = { enable = true },
  picker = { enabled = false },
  quickfile = { enabled = true },
  notifier = {
    enabled = false,
    top_down = true,
  },
  util = { enabled = true },
  words = { enabled = true },
})

vim.ui.input = Snacks.input.input
-- vim.ui.select = Snacks.picker.select
-- vim.notify = Snacks.notifier.notify

require('plugins.snacks.keymap')
require('plugins.snacks.autocmd')
