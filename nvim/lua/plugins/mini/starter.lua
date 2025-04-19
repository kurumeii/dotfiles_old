local starter = require('mini.starter')

starter.setup({
  query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_.',
  -- stylua: ignore
  items = {
    starter.sections.sessions(5, true),
    starter.sections.recent_files(3, false, false),
    {
      { name = "Mason Sync",    action = "MasonUpdate", section = "Updaters" },
      { name = "Update deps",   action = "DepsUpdate",            section = "Updaters" },
      { name = "New buffer",    action = "enew",                  section = "Builtin actions" },
      { name = "Visited files", action = "Pick visit_paths",      section = "Builtin actions" },
      { name = "Quit Neovim",   action = "qall",                  section = "Builtin actions" },
    },
  },
  header = function()
    return [[
 _._     _,-'""`-._
(,-.`._,'(       |\`-/|
    `-.-' \ )-`( , o o)
          `-    \`_`"'-

=========================================
      |\      _,,,---,,_
ZZZzz /,`.-'`'    -.  ;-;;,_
     |,4-  ) )-,_. ,\ (  `'-'
    '---''(_/--'  `-'\_)
    ]]
  end,
  footer = 'Hoang Anh',
})
