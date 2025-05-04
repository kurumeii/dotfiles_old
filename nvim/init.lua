require('config.mini').setup({
  { source = 'config.option' },
  { source = 'config.keymap' },
  {
    source = 'folke/snacks.nvim',
    cb = function()
      require('plugins.snacks')
    end,
  },
  {
    source = 'plugins.theme',
    cb = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  { source = 'plugins.mini.icons' },
  { source = 'plugins.mini.basics' },
  { source = 'mini.colors', opts = {}, later = true },
  { source = 'plugins.mini.sessions', later = true },
  { source = 'plugins.mini.animate', later = true },
  { source = 'plugins.mini.bracketed', later = true },
  { source = 'plugins.mini.surround', later = true },
  { source = 'plugins.mini.jump', later = true },
  { source = 'mini.pairs', later = true, opts = {} },
  { source = 'plugins.mini.cursorword', later = true },
  { source = 'mini.trailspace', later = true, opts = {} },
  { source = 'mini.fuzzy', later = true, opts = {} },
  { source = 'mini.extra', later = true, opts = {} },
  { source = 'mini.operators', later = true, opts = {} },
  { source = 'mini.comment', later = true, opts = {} },
  { source = 'plugins.mini.bufremove', later = true },
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
  },
  {
    source = 'plugins.mini.pick',
    later = true,
    disable = true,
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
    disable = true,
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
    disable = true,
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
    source = 'plugins.others.noice',
    later = true,
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
    depends = { 'neovim/nvim-lspconfig' },
    cb = function()
			local navic = require('nvim-navic')
      navic.setup({
        highlight = true,
        separator = ' > ',
        depth_limit = 3,
      })
      vim.api.nvim_create_autocmd('BufWinEnter', {
        callback = function()
          if navic.is_available() then
            vim.wo.winbar = navic.get_location()
          end
        end,
      })
    end,
  },
  {
    source = 'plugins.mini.statusline',
    later = true,
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
    source = 'plugins.others.conform',
    later = true,
  },
  {
    source = 'plugins.others.fold',
    later = true,
  },
  {
    source = 'plugins.others.supermaven',
    later = true,
    disable = true,
  },
  {
    source = 'plugins.others.lint',
    later = true,
  },
  {
    source = 'eero-lehtinen/oklch-color-picker.nvim',
    later = true,
    disable = true,
    cb = function()
      require('plugins.others.colorizer')
    end,
  },
})
