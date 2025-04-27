require('mini.statusline').setup()
MiniDeps.add({
  source = 'justinhj/battery.nvim',
  depends = {
    'nvim-lua/plenary.nvim',
  },
})
local battery = require('battery')

battery.setup({
	show_percent = true,
	show_plugged_icon = true,
	show_unplugged_icon = true,
	show_status_when_no_battery = true,
  vertical_icons = false,
	update_rate_seconds = 20
})

local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
local git = MiniStatusline.section_git({ trunc_width = 40 })
local diff = MiniStatusline.section_diff({ trunc_width = 75 })
local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
local filename = MiniStatusline.section_filename({ trunc_width = 100 })
local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
local location = MiniStatusline.section_location({ trunc_width = 75 })
local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
local nvim_battery = battery.get_status_line()

MiniStatusline.config.content.active = function()
  return MiniStatusline.combine_groups({
    { hl = mode_hl, strings = { mode } },
    {
      hl = 'MiniStatuslineDevinfo',
      strings = { git, diff, diagnostics, lsp },
    },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
    { hl = 'MiniStatuslineLocation', strings = { nvim_battery } },
    { hl = mode_hl, strings = { search, location } },
  })
end
