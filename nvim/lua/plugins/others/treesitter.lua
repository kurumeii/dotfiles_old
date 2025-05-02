require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'lua',
    'query',
    'git_rebase',
    'diff',
    'gitcommit',
    'git_config',
    'css',
    'jsdoc',
    'json',
    'jsonc',
    'luadoc',
    'toml',
		'regex'
  },
  auto_install = true,
})

require('treesitter-context').setup()
