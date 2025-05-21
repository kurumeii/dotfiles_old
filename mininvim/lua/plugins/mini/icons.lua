require('mini.icons').setup({
  file = {
    ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
    ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
    ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
    ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['vite.config.ts'] = { glyph = '', hl = 'MiniIconsYellow' },
    ['pnpm-lock.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
    ['pnpm-workspace.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
    ['.dockerignore'] = { glyph = '󰡨', hl = 'MiniIconsBlue' },
    ['react-router.config.ts'] = { glyph = '', hl = 'MiniIconsRed' },
  },
  directory = {
    ['.vscode'] = { glyph = '', hl = 'MiniIconsBlue' },
    ['app'] = { glyph = '󰀻', hl = 'MiniIconsRed' },
    ['routes'] = { glyph = '󰑪', hl = 'MiniIconsGreen' },
    ['config'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['configs'] = { glyph = '', hl = 'MiniIconsGrey' },
    ['server'] = { glyph = '󰒋', hl = 'MiniIconsCyan' },
  },
})
MiniIcons.mock_nvim_web_devicons()
MiniDeps.later(function()
  MiniIcons.tweak_lsp_kind('prepend')
end)
