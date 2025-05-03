local js = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
local adapters = { 'pwa-node', 'pwa-msedge', 'node-terminal' }
local dap = require('dap')
local vscode = require('dap.ext.vscode')
local json = require('plenary.json')

vscode.json_decode = function(str)
  return vim.json.decode(json.json_strip_comments(str))
end

for _, adapter in ipairs(adapters) do
  dap.adapters[adapter] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
			command = "node",
			args = {
				vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
				"${port}"
			}
    },
  }
end
for _, lang in ipairs(js) do
  dap.configurations[lang] = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to node process',
      type = 'pwa-node',
      request = 'attach',
      rootPath = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
    },
  }
end
