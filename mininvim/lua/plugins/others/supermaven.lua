MiniDeps.add({
	source = "supermaven-inc/supermaven-nvim",
	name = "supermaven",
})

require("supermaven-nvim").setup({
	keymaps = {
		accept_suggestion = '<Tab>',
		clear_suggestion = "<C-c>",
		accept_word = "<c-j>",
	},
})
