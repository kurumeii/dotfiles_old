MiniDeps.add({
  source = 'mfussenegger/nvim-dap',
  depends = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'jbyuki/one-small-step-for-vimkind',
    'nvim-neotest/nvim-nio',
    'mxsdev/nvim-dap-vscode-js',
  },
})

MiniDeps.add({
  source = 'microsoft/vscode-js-debug',
  hooks = {
    post_install = function(path)
      vim.fn.system({ 'pnpm', 'install' }, path)
      vim.fn.system({ 'npx', 'gulp', 'vsDebugServerBundle' }, path)
      vim.fn.system({ 'mv', 'dist', 'out' }, path)
    end,
  },
})

local utils = require('utils')
local map, L = utils.map, utils.L
local dap = require('dap')
local dapui = require('dapui')

-- TOD: Config the icons
dapui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
})

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

-- TODO: Check later if these configs were working as expected
require('dap-vscode-js').setup({
  debugger_path = vim.fn.stdpath('data')
    .. '/site/pack/deps/opt/vscode-js-debug',
  adapters = {
    'pwa-node',
    'pwa-msedge',
    'node-terminal',
  },
})

local vscode = require('dap.ext.vscode')
local json = require('plenary.json')
vscode.json_decode = function(str)
  return vim.json.decode(json.json_strip_comments(str))
end

require('config.dap')

-- REMAPS ====================================================================
map('n', L('dc'), function()
  dap.continue()
end, '[D]ebug continue')

map('n', L('dbt'), function()
  dap.toggle_breakpoint()
end, '[D]ebug [B]reakpoint [T]oggle')

map('n', L('dbs'), function()
  dap.toggle_breakpoint()
end, '[D]ebug [B]reakpoint [S]et')

map('n', L('du'), function()
  dapui.toggle({})
end, '[D]ebug [U]i')

map('n', L('de'), function()
  dapui.eval()
end, '[D]ebug [E]val')
