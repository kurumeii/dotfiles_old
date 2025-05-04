local MiniStatusline = require('mini.statusline')
local battery = require('battery')
-- local navic = require('nvim-navic')
local width = vim.api.nvim_win_get_width(0)
local H = {}

local filename = MiniStatusline.section_filename({ trunc_width = 100 })

MiniStatusline.setup({
  content = {
    inactive = function()
      local pathname = H.section_pathname({ trunc_width = 120 })
      return MiniStatusline.combine_groups({
        { hl = 'MiniStatuslineInactive', strings = { pathname } },
      })
    end,
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ icon = '', trunc_width = 40 })
      -- local diff = MiniStatusline.section_diff({ trunc_width = 60 })
      local diagnostics = MiniStatusline.section_diagnostics({
        icon = '| 󰂓',
        signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = ' ' },
        trunc_width = 75,
      })
      local lsp = MiniStatusline.section_lsp({ icon = '| ', trunc_width = 75 })
      -- local breadcrumb = navic.get_location()
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = width < 80 and 30 or 120 })
      -- local location = width < 100 and "" or MiniStatusline.section_location({ trunc_width = 75 })
      -- local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local nvim_battery = battery.get_status_line()

      return MiniStatusline.combine_groups({
        {
          hl = 'MiniStatuslineDevinfo',
          strings = { git, diagnostics },
        },
        '%<', -- Mark general truncate point
        {
          hl = 'MiniStatuslineFilename',
          strings = { filename },
        },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, lsp } },
        -- { hl = mode_hl, strings = { search } },
        { hl = 'MiniStatuslineLocation', strings = { nvim_battery } },
        { hl = mode_hl, strings = { mode } },
      })
    end,
  },
})

H.section_pathname = function(args)
  args = vim.tbl_extend('force', {
    modifiled_hl = nil,
    filename_hl = nil,
    trunc_width = 80,
  }, args or {})
  if vim.bo.buftype == 'terminal' then
    return '%t'
  end

  local path = vim.fn.expand('%:p')
  local cwd = vim.uv.cwd()
  cwd = vim.uv.fs_realpath(cwd) or ''

  if path:find(cwd, 1, true) then
    path = path:sub(#cwd + 2)
  end
  local sep = package.config:sub(1, 1)
  local parts = vim.split(path, sep)
  if MiniStatusline.is_truncated(args.trunc_width) and #parts > 3 then
    parts = {
      parts[1],
      '...',
      parts[#parts - 1],
      parts[#parts],
    }
  end
  local dir = ''
  if #parts > 1 then
    dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
  end

  local file = parts[#parts]
  local file_hl = ''
  if vim.bo.modified and args.modified_hl then
    file_hl = '%#' .. args.modified_hl .. '#'
  elseif args.filename_hl then
    file_hl = '%#' .. args.filename_hl .. '#'
  end
  local modified = vim.bo.modified and ' ' or ''
  return dir .. file_hl .. file .. modified
end
