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
    source = 'folke/snacks.nvim',
    cb = function()
      require('plugins.snacks')
    end,
  },
  {
    source = 'plugins.theme',
    cb = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  { source = 'plugins.mini.icons' },
  { source = 'plugins.mini.basics' },
  { source = 'mini.colors', opts = {}, later = true },
  { source = 'mini.keymap', opts = {}, later = true },
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
  {
    source = 'plugins.mini.misc',
    later = true,
  },
  {
    source = 'plugins.mini.snippets',
    later = true,
  },
  {
    source = 'plugins.mini.jump2d',
    later = true,
  },
  {
    source = 'plugins.mini.tabline',
    later = true,
    disable = false,
  },
  {
    source = 'plugins.mini.pick',
    later = true,
    disable = false,
  },
  {
    source = 'plugins.mini.diff',
    later = true,
  },
  {
    source = 'plugins.mini.git',
    later = true,
  },
  { source = 'plugins.mini.ai', later = true },
  {
    source = 'plugins.mini.indentscope',
    later = true,
    disable = false,
  },
  {
    source = 'plugins.mini.completion',
    later = true,
    disable = false,
  },
  {
    source = 'plugins.others.blink-cmp',
    later = true,
    disable = true,
  },
  {
    source = 'plugins.mini.hipatterns',
    later = true,
  },
  {
    source = 'plugins.mini.minimap',
    later = true,
  },
  {
    source = 'plugins.mini.files',
    later = true,
  },
  {
    source = 'plugins.mini.clues',
    later = true,
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
    cb = function()
      require('better_escape').setup()
    end,
  },
  {
    source = 'windwp/nvim-ts-autotag',
    later = true,
    cb = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    source = 'folke/noice.nvim',
    depends = { 'MunifTanjim/nui.nvim' },
    later = true,
    disable = true,
    cb = function()
      require('plugins.others.noice')
    end,
  },
  {
    source = 'TheLeoP/powershell.nvim',
    later = true,
    disable = true,
    cb = function()
      require('powershell').setup({
        bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services',
      })
    end,
  },
  {
    source = 'justinhj/battery.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
    },
    cb = function()
      require('battery').setup({
        vertical_icons = false,
        update_rate_seconds = 20,
      })
    end,
  },
  {
    source = 'SmiteshP/nvim-navic',
    later = true,
    cb = function()
      require('plugins.others.breadcrumbs')
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
      require('plugins.others.fold')
    end,
  },
  {
    source = 'plugins.others.supermaven',
    later = true,
    disable = false,
  },
  {
    source = 'mfussenegger/nvim-lint',
    later = true,
    cb = function()
      require('plugins.others.lint')
    end,
  },
  {
    source = 'eero-lehtinen/oklch-color-picker.nvim',
    later = true,
    disable = true,
    cb = function()
      require('plugins.others.colorizer')
    end,
  },
  {
    source = 'MagicDuck/grug-far.nvim',
    later = true,
    cb = function()
      require('plugins.others.grug-far')
    end,
  },
})
