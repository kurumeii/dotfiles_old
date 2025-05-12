local MiniStatusline = require('mini.statusline')
local battery = require('battery')

local function get_time()
  return mininvim.icons.clock .. ' ' .. os.date('%R')
end

local function recorder_section()
  local reg = vim.fn.reg_recording()
  if reg ~= '' then
    return mininvim.icons.recording .. ' ' .. reg
  end
  return ''
end

local function get_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then
    return mininvim.icons.no_lsp
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  local icon = mininvim.icons.lsp
  if #names > 2 then
    return icon .. '+' .. #names
  else
    return icon .. ' ' .. table.concat(names, ',')
  end
end

--- @param mode 'percent' | 'line'
local function get_location(mode)
  if mode == 'percent' then
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local total_lines = vim.api.nvim_buf_line_count(0)
    if current_line == 1 then
      return 'TOP'
    elseif current_line == total_lines then
      return 'BOTTOM'
    else
      return '%p%%'
    end
  else
    return '%l|%v'
  end
end

local function active_mode()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 250 })
  mode = mininvim.icons.mode_prepend .. ' ' .. mode

  local git = MiniStatusline.section_git({ icon = mininvim.icons.git_branch, trunc_width = 40 })
  local diff = MiniStatusline.section_diff({ icon = '', trunc_width = 100 })
  local diagnostics = MiniStatusline.section_diagnostics({
    icon = '',
    signs = {
      ERROR = mininvim.icons.error .. ' ',
      WARN = mininvim.icons.warn .. ' ',
      INFO = mininvim.icons.info .. ' ',
      HINT = mininvim.icons.hint .. ' ',
    },
    trunc_width = 75,
  })
  local lsp = get_lsp()
  local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 200 })
  local location = get_location('percent')
  local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
  local nvim_battery = battery.get_status_line()
  local time = get_time()
  local recorder = recorder_section()
  local filename = MiniStatusline.section_filename({ trunc_width = 250 })
  return MiniStatusline.combine_groups({
    { hl = mode_hl, strings = { mode } },
    {
      hl = '',
      strings = { git },
    },
    {
      hl = 'MiniStatuslineDevinfo',
      strings = { diff, diagnostics },
    },
    '%<', -- Mark general truncate point
    {
      hl = 'MiniStatuslineFilename',
      strings = { filename },
    },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { recorder, lsp, fileinfo } },
    { hl = '', strings = { nvim_battery } },
    { hl = mode_hl, strings = { search, location, time } },
  })
end

MiniStatusline.setup({
  content = {
    active = active_mode,
  },
})
