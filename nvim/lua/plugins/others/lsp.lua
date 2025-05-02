MiniDeps.add({
  source = 'neovim/nvim-lspconfig',
  depends = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'folke/lazydev.nvim',
  },
})

MiniDeps.add({
  source = 'justinsgithub/wezterm-types',
})

MiniDeps.add({
  source = 'b0o/SchemaStore.nvim',
})

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
    on_attach = function(client, bufnr)
      if not client then
        vim.notify_once('twcs-colors: Attach to a nil value', vim.log.levels.WARN)
        return
      end
      require('tailwindcss-colors').buf_attach(bufnr)
    end,
  },
  vtsls = {
    on_attach = function(client, bufnr)
      require('nvim-navic').attach(client, bufnr)
    end,
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
  -- using tailwindcss should be enough
  -- cssls = {},
  lua_ls = {
    on_attach = function(client, bufnr)
      require('nvim-navic').attach(client, bufnr)
    end,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = 'Replace',
        },
        doc = {
          privateName = { '^_' },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = false,
          paramName = 'Disable',
          semicolon = 'Disable',
          arrayIndex = 'Disable',
        },
      },
    },
  },
  stylua = {},
  cspell = {},
  markdownlint = {},
  biome = {},
  powershell_es = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
				extra = {
					{
						description = 'Shadcn JSON schema',
						filematch = {'components.json'},
						name = 'components.json',
						url = 'https://ui.shadcn.com/schema.json'
					}
				}
      },
    },
  },
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = ''
				},
				schemas = require('schemastore').yaml.schemas(),
			}
		}
	}
}

vim.diagnostic.config({
  severity_sort = true,
  inlay_hints = {
    enabled = true,
  },
  float = { border = 'single', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 3,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

local ensure_installed = vim.tbl_keys(local_server or {})

---@diagnostic disable-next-line: missing-fields
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
			}
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
local file_operations = {
  workspace = {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  },
}
capabilities = vim.tbl_deep_extend(
  'force',
  capabilities,
  mini_capabilities,
  -- blink_capabilities,
  file_operations
)

require('mason-lspconfig').setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = local_server[server_name] or {}
      require('lspconfig')[server_name].setup(server)
    end,
  },
})

-- require('mason-nvim-dap').setup({
--   ensure_installed = {},
--   automatic_installation = false,
-- })

require('mason-tool-installer').setup({
  ensure_installed = ensure_installed,
})

-- keymaps
----------------------------
local utils = require('utils')
local map, L = utils.map, utils.L

map('n', L('lR'), function()
  vim.cmd('LspRestart')
end, '[L]sp: [R]eset Server')
