require('mini.files').setup({
  windows = {
    preview = false,
    -- width_focus = 30,
    -- width_preview = 30,
    --
  },
  options = {
    use_as_default_explorer = true,
  },
})

local show_dotfiles = true
local filter_show = function(_)
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

local map_split = function(buf_id, lhs, direction, close_on_file)
  local rhs = function()
    local new_target_window
    local cur_target_window = MiniFiles.get_explorer_state().target_window
    if cur_target_window ~= nil then
      vim.api.nvim_win_call(cur_target_window, function()
        vim.cmd('belowright ' .. direction .. ' split')
        new_target_window = vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target_window)
      MiniFiles.go_in({ close_on_file = close_on_file })
    end
  end

  local desc = 'Open in ' .. direction .. ' split'
  if close_on_file then
    desc = desc .. ' and close'
  end
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

local files_set_cwd = function()
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  if cur_directory ~= nil then
    vim.fn.chdir(cur_directory)
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id

    vim.keymap.set(
      'n',
      'g.',
      toggle_dotfiles,
      { buffer = buf_id, desc = 'Toggle hidden files' }
    )

    vim.keymap.set(
      'n',
      'gc',
      files_set_cwd,
      { buffer = args.data.buf_id, desc = 'Set cwd' }
    )

    map_split(buf_id, '<C-w>s', 'horizontal', false)
    map_split(buf_id, '<C-w>v', 'vertical', false)
    map_split(buf_id, '<C-w>S', 'horizontal', true)
    map_split(buf_id, '<C-w>V', 'vertical', true)
  end,
})

-- MiniFile (Tree)
local utils = require('utils')
local map, L = utils.map, utils.L

map('n', L('e'), function()
  local getCurrentDir = pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0))
  if not getCurrentDir then
    MiniFiles.open()
  end
end, 'Open explore')
