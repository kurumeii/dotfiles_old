local MiniStatusline = require('mini.statusline')
local battery = require('battery')

function _G.statusline_time()
  return os.date('%H:%M') .. ' ' .. mininvim.icons.clock .. ' '
end

function _G.recorder()
  local reg = vim.fn.reg_recording()
  if reg ~= '' then
    return mininvim.icons.recording .. ' ' .. reg
  end
  return ''
end

MiniStatusline.setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      mode = mininvim.icons.mode_prepend .. ' ' .. mode

      local git = MiniStatusline.section_git({ icon = mininvim.icons.git_branch, trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ icon = '|', trunc_width = 100 })
      local diagnostics = MiniStatusline.section_diagnostics({
        icon = '|',
        signs = {
          ERROR = mininvim.icons.error .. ' ',
          WARN = mininvim.icons.warn .. ' ',
          INFO = mininvim.icons.info .. ' ',
          HINT = mininvim.icons.hint .. ' ',
        },
        trunc_width = 75,
      })
      MiniStatusline.section_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if #clients == 0 then
          return '󱏎 No LSP'
        end
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return mininvim.icons.lsp .. ' ' .. table.concat(names, ', ')
      end
      local lsp = MiniStatusline.section_lsp()
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 150 })
      MiniStatusline.section_location = function()
        return '%2l|%-2v'
      end
      local location = MiniStatusline.section_location()
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local nvim_battery = battery.get_status_line()
      local time = '%{v:lua.statusline_time()}'
      local recorder = '%{v:lua.recorder()}'
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
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
    end,
  },
})
