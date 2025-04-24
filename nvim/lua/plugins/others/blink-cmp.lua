local utils = require('utils')
local notify = utils.notify

local function build_blink(params)
  notify('Building blink.cmp', 'INFO')
  local obj = vim
    .system({ 'cargo', 'build', '--release' }, { cwd = params.path })
    :wait()
  if obj.code == 0 then
    notify('Building blink.cmp done', 'INFO')
  else
    notify('Building blink.cmp failed', 'ERROR')
  end
end

MiniDeps.add({
  source = 'saghen/blink.cmp',
  hooks = {
    post_install = build_blink,
    post_checkout = build_blink,
  },
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
  },
  completion = {
    documentation = {
      auto_show = true,
    },
    menu = {
      draw = {
        treesitter = { 'lsp' },
      },
    },
  },
  signature = {
    enabled = true,
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'normal',
  },
  snippets = {
    preset = 'mini_snippets',
  },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
  },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
  },
})
