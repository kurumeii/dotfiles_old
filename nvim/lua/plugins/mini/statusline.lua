local MiniStatusline = require('mini.statusline')
MiniDeps.add({
  source = 'justinhj/battery.nvim',
  depends = {
    'nvim-lua/plenary.nvim',
  },
})
MiniDeps.add({
  source = 'SmiteshP/nvim-navic',
  depends = {
    'neovim/nvim-lspconfig',
  },
})

local battery = require('battery')

battery.setup({
  show_percent = true,
  show_plugged_icon = true,
  show_unplugged_icon = true,
  show_status_when_no_battery = true,
  vertical_icons = false,
  update_rate_seconds = 20,
})

local navic = require('nvim-navic')

navic.setup({
  highlight = true,
  separator = ' > ',
  depth_limit = 4,
})

local width = vim.api.nvim_win_get_width(0)

MiniStatusline.setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      -- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      -- local filename = MiniStatusline.section_filename({ trunc_width = 100 })
      local breadcrumbs = navic.is_available() and navic.get_location()
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = width < 80 and 30 or 120 })
      -- local location = width < 100 and "" or MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local nvim_battery = battery.get_status_line()

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        {
          hl = 'MiniStatuslineDevinfo',
          strings = { git, diff, diagnostics },
        },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { breadcrumbs } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search } },
        { hl = 'MiniStatuslineLocation', strings = { nvim_battery } },
      })
    end,
  },
})
