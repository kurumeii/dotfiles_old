local starter = require('mini.starter')

starter.setup({
  items = {
    starter.sections.sessions(),
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
		{
			name = 'Edit config ',
			action = 'edit $MYVIMRC',
			section = 'Core',
		},
		{
			name = "Quit",
			action = 'qa',
			section = 'Core',
		}
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
