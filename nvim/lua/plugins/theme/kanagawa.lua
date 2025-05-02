MiniDeps.add({
  source = 'rebelot/kanagawa.nvim',
})
require('kanagawa').setup({
	compile = true,
	transparent = false,
	dimInactive = true,
	background = {
		light = 'lotus',
		dark = 'wave',
	}
})
