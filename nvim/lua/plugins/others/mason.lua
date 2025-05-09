local local_server = {
  tailwindcss = {
    filetypes = {
      'html',
      'css',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    settings = {
      tailwindCSS = {
        classFunctions = {
          'cva',
          'cx',
        },
      },
    },
  },
  vtsls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  lua_ls = {},
  selene = {},
  stylua = {},
  cspell = {},
  marksman = {},
  ['markdownlint-cli2'] = {},
  ['markdown-toc'] = {},
  biome = {},
  powershell_es = {},
  yamlfix = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas({
          extra = {
            {
              description = 'Shadcn JSON schema',
              filematch = { 'components.json' },
              name = 'components.json',
              url = 'https://ui.shadcn.com/schema.json',
            },
            {
              description = 'lua json schema',
              filematch = { '.luarc.json' },
              name = 'luarc.json',
              url = 'https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json',
            },
          },
        }),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
}

local ensure_installed = vim.tbl_keys(local_server or {})

require('lazydev').setup({
  integrations = {
    lspconfig = true,
  },
  library = {
    'nvim-dap-ui',
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    { path = 'wezterm-types', mods = { 'wezterm' } },
  },
})

require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local mini_capabilities = MiniCompletion.get_lsp_capabilities({
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
})
-- local blink_capabilities = require('blink.cmp').get_lsp_capabilities({
-- 	textDocument = {
-- 		foldingRange = {
-- 			dynamicRegistration = false,
-- 			lineFoldingOnly = true
-- 		}
-- 	}
-- })

require('mason-tool-installer').setup({
  ensure_installed = ensure_installed,
})

require('mason-lspconfig').setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = require('lspconfig')[server_name]
      server.capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        mini_capabilities,
        -- blink_capabilities,
        {
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
      server.on_attach = function(client, bufnr)
        if client.server_capabilities['documentSymbolProvider'] then
          require('nvim-navic').attach(client, bufnr)
        end
      end

      vim.lsp.config(server_name, server)
      vim.lsp.enable(server_name)
    end,
  },
})

-- keymaps
----------------------------
local utils = require('utils')
utils.map('n', utils.L('lR'), function()
  vim.cmd('LspRestart')
end, 'Lsp restart server')
utils.map('i', '<C-l>', vim.lsp.buf.signature_help, 'Signature help')
