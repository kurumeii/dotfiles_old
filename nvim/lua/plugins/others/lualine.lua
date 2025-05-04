local navic = require('nvim-navic')
local battery = require('battery')

navic.setup({
  highlight = true,
  depth_limit = 4,
})

require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
				icons_enabled = false,
				fmt = function(str)
					return ' ' .. str
				end
      },
    },
    lualine_b = {
      {
        'branch',
        icon = mininvim.icons.git_branch,
      },
    },
    lualine_c = {
      {
        'diff',
        symbols = {
          added = mininvim.icons.git_add .. ' ',
          modified = mininvim.icons.git_edit .. ' ',
          removed = mininvim.icons.git_remove .. ' ',
        },
      },
      {
        'diagnostics',
        always_visible = false,
        symbols = {
          error = mininvim.icons.error .. ' ',
          warn = mininvim.icons.warn .. ' ',
          info = mininvim.icons.info .. ' ',
          hint = mininvim.icons.hint .. ' ',
        },
      },
      '%=',
    },
    lualine_x = {
      {
        'lsp_status',
        icon = mininvim.icons.lsp,
        symbols = {
          spinner = '',
        },
      },
      -- 'encoding',
      'filetype',
      { battery.get_status_line },
    },
    lualine_y = {
      'searchcount',
      {
        'datetime',
        style = '%H:%M' .. ' ' .. mininvim.icons.clock,
      },
    },
    lualine_z = {
      'location',
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  winbar = {
    lualine_c = {
      'navic',
      color_correction = nil,
      navic_opts = nil,
    },
  },
})
