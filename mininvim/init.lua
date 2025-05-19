_G.mininvim = {
  icons = require('config.icons'),
  tw_colors = require('config.tailwind-color'),
  word_colors = require('config.color-word'),
}
require('config.mini').setup({
  { source = 'config.option' },
  { source = 'config.keymap' },
  { source = 'plugins.mini.sessions' },
  { source = 'plugins.mini.notify', disable = false },
  { source = 'plugins.mini.starter', disable = false },
  {
    source = 'catppuccin/nvim',
    name = 'catppuccin',
    cb = function()
      require('plugins.theme.catppuccin')
    end,
  },
  {
    source = 'folke/tokyonight.nvim',
    cb = function()
      require('plugins.theme.tokyonight')
    end,
  },
  {
    source = 'rebelot/kanagawa.nvim',
    cb = function()
      require('plugins.theme.kanagawa')
    end,
  },
  {
    source = 'AstroNvim/astrotheme',
    cb = function()
      require('plugins.theme.astro')
    end,
  },
  { source = 'plugins.mini.icons' },
  { source = 'plugins.mini.basics' },
  { source = 'mini.colors', later = true, opts = {} },
  { source = 'mini.keymap', later = true, opts = {} },
  { source = 'plugins.mini.animate', later = true },
  { source = 'plugins.mini.bracketed', later = true },
  { source = 'plugins.mini.surround', later = true },
  { source = 'plugins.mini.jump', later = true },
  { source = 'plugins.mini.pairs', later = true },
  { source = 'plugins.mini.cursorword', later = true },
  { source = 'mini.trailspace', later = true, opts = {} },
  { source = 'mini.fuzzy', later = true, opts = {} },
  { source = 'mini.extra', later = true, opts = {} },
  { source = 'mini.operators', later = true, opts = {} },
  { source = 'mini.comment', later = true, opts = {} },
  { source = 'mini.bufremove', later = true, opts = {} },
  { source = 'plugins.mini.misc', later = true },
  { source = 'plugins.mini.snippets', later = true },
  { source = 'plugins.mini.jump2d', later = true },
  { source = 'plugins.mini.tabline', later = true, disable = false },
  { source = 'plugins.mini.pick', later = true, disable = false },
  { source = 'plugins.mini.diff', later = true },
  { source = 'plugins.mini.git', later = true },
  { source = 'plugins.mini.ai', later = true },
  { source = 'plugins.mini.indentscope', later = true, disable = false },
  { source = 'plugins.mini.completion', later = true, disable = false },
  { source = 'plugins.others.blink-cmp', later = true, disable = true },
  { source = 'plugins.mini.hipatterns', later = true },
  { source = 'plugins.mini.minimap', later = true },
  {
    source = 'plugins.mini.files',
    later = false,
    disable = false,
  },
  {
    source = 'plugins.mini.clues',
  },
  {
    source = 'plugins.mini.visited',
    later = true,
    disable = false,
  },
  {
    source = 'nvim-treesitter/nvim-treesitter',
    later = true,
    hooks = {
      post_checkout = function()
        vim.cmd('TSUpdate')
      end,
    },
    depends = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    cb = function()
      require('plugins.others.treesitter')
    end,
  },
  {
    source = 'max397574/better-escape.nvim',
    later = true,
    name = 'better_escape',
    opts = {},
  },
  {
    source = 'windwp/nvim-ts-autotag',
    later = true,
    opts = {},
  },
  {
    source = 'TheLeoP/powershell.nvim',
    later = true,
    name = 'powershell',
    opts = {
      bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
    },
  },
  {
    source = 'justinhj/battery.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
    },
    name = 'battery',
    opts = {
      vertical_icons = false,
      update_rate_seconds = 20,
    },
  },
  {
    source = 'SmiteshP/nvim-navic',
    depends = {
      'neovim/nvim-lspconfig',
    },
    later = true,
    cb = function()
      require('nvim-navic').setup({
        highlight = true,
        depth_limit = 4,
      })
      -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },
  {
    source = 'nvim-lualine/lualine.nvim',
    depends = {
      'SmiteshP/nvim-navic',
    },
    disable = true,
    later = true,
    cb = function()
      require('plugins.others.lualine')
    end,
  },
  {
    source = 'plugins.mini.statusline',
    later = true,
    disable = false,
  },
  {
    source = 'neovim/nvim-lspconfig',
    later = true,
    depends = {
      'williamboman/mason.nvim', -- mason core
      'williamboman/mason-lspconfig.nvim', -- mason lsp
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- mason easy installer
      'justinsgithub/wezterm-types',
      'b0o/SchemaStore.nvim',
      'folke/lazydev.nvim',
    },
    cb = function()
      require('plugins.others.mason')
    end,
  },
  {
    source = 'mfussenegger/nvim-dap',
    later = true,
    depends = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'jbyuki/one-small-step-for-vimkind',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim', -- mason dap
    },
    cb = function()
      require('plugins.others.debugger')
    end,
  },
  {
    source = 'stevearc/conform.nvim',
    later = true,
    cb = function()
      require('plugins.others.conform')
    end,
  },
  {
    source = 'kevinhwang91/nvim-ufo',
    depends = {
      'kevinhwang91/promise-async',
    },
    later = true,
    cb = function()
      require('ufo').setup({
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      })
    end,
  },
  {
    source = 'supermaven-inc/supermaven-nvim',
    later = true,
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-c>',
        accept_word = '<c-j>',
      },
    },
  },
  {
    source = 'mfussenegger/nvim-lint',
    later = true,
    cb = function()
      require('plugins.others.lint')
    end,
  },
  {
    source = 'MagicDuck/grug-far.nvim',
    later = true,
    cb = function()
      require('plugins.others.grug-far')
    end,
  },
  {
    source = 'folke/snacks.nvim',
    later = true,
    cb = function()
      require('plugins.snacks')
    end,
  },
})
vim.cmd.colorscheme('tokyonight')
