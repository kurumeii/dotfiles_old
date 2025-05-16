local lint = require('lint')

lint.linters.biome = function()
  local default = require('lint.linters.biomejs')
  return default
end
