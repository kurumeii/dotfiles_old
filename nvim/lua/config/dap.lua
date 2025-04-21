local js = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

local dap = require('dap')

for _, lang in ipairs(dap) do
  dap.configurations[lang] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch localhost',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-msedge',
      request = 'launch',
      name = 'Launch Edge',
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      -- userDataDir = "${workspaceFolder}/.vscode/vscode-edge-debug"
    },
  }
end
