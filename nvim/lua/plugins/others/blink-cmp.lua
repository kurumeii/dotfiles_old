local function build_blink(params)
  MiniNotify.add('Building blink.cmp', 'INFO')
  local obj = vim
    .system({ 'cargo', 'build', '--release' }, { cwd = params.path })
    :wait()
  if obj.code == 0 then
    MiniNotify.add('Building blink.cmp done', 'INFO')
  else
    MiniNotify.add('Building blink.cmp failed', 'ERROR')
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
  -- appearance = {
  --   use_nvim_cmp_as_default = true,
  --   nerd_font_variant = 'normal',
  -- },
})
