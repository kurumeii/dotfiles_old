require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

require('mason-tool-installer').setup({
  ensure_installed = {
    'tailwindcss',
    'vtsls',
    'lua_ls',
    'stylua',
    'cspell',
    'marksman',
    'markdownlint-cli2',
    'markdown-toc',
    'biome',
    'powershell_es',
    'yamlfix',
    'jsonls',
    'yamlls',
    'taplo',
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {},
  automatic_enable = true,
})

---@type lsp.ClientCapabilities
local capabilities = vim.tbl_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  -- require('blink.cmp').get_lsp_capabilities({}, false),
  require('mini.completion').get_lsp_capabilities(),
  {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }
)

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
    end
  end,
})

-- keymaps
----------------------------
local utils = require('utils')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    utils.map('n', utils.L('lR'), function()
      vim.cmd('LspRestart')
    end, 'Lsp restart server')
    utils.map('i', '<C-l>', vim.lsp.buf.signature_help, 'Signature help', {
      buffer = args.bufnr,
    })
  end,
})
