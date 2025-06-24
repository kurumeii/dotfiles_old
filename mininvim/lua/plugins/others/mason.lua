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

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    utils.map('i', '<C-l>', vim.lsp.buf.signature_help, 'Signature help', {
      buffer = args.bufnr,
    })
    utils.map('n', utils.L('cr'), function()
      vim.ui.input({ prompt = 'Rename to: ' }, function(new_name)
        if not new_name then
          utils.notify('Rename cancelled', 'WARN')
        else
          vim.lsp.buf.rename(new_name, { bufnr = args.bufnr })
          utils.notify('Rename successfully')
        end
      end)
    end, 'Rename')
    utils.map(
      'n',
      utils.L('co'),
      function()
        utils.lsp_action('source.fixAll')
      end,
      '[TS] Organize imports',
      {
        buffer = args.bufnr,
      }
    )
  end,
})
