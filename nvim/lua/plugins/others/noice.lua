MiniDeps.add({
  source = 'folke/noice.nvim',
  depends = {
    'MunifTanjim/nui.nvim',
  },
})

require('noice').setup({
  lsp = {
		progress = {
			enabled = false
		},
  },
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	routes = {
		{
			view = 'notify',
			filter = { event = 'msg_showmode' },
		}
	}
})
