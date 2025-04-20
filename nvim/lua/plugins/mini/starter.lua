local starter = require('mini.starter')

starter.setup({
  items = {
    starter.sections.sessions(5, true),
    starter.sections.recent_files(3),
    {
      { name = 'Mason Sync', action = 'MasonUpdate', section = 'Updaters' },
      {
        name = 'Update deps',
        action = 'DepsUpdate',
        section = 'Updaters',
      },
    },
    starter.sections.pick(),
    starter.sections.builtin_actions(),
  },

  header = function()
    return [[
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-
    ]]
  end,
  footer = 'Hoang Anh',
})
