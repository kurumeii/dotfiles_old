MiniDeps.add({
  source = "nvim-treesitter/nvim-treesitter",
  checkout = 'master',
  monitor = 'main',
  hooks = {
    post_checkout = function()
      vim.cmd('TSUpdate')
    end,
  },
  depends = {
    'nvim-treesitter/nvim-treesitter-context'
  }
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true
  },
  ensure_installed = {
    "lua", "query", "git_rebase", "diff", "gitcommit", "git_config", 'css',
    "jsdoc", "json", "jsonc", "luadoc", "toml",
  },
  auto_install = true,
})

require('treesitter-context').setup()
