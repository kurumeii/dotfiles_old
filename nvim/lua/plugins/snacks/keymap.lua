local util = require('utils')
local map, L = util.map, util.L

map('n', L('G'), function()
  Snacks.lazygit.open()
end, 'Open Lazy[G]it')

map('n', L('t'), Snacks.terminal.toggle, 'Toggle Terminal')
-- And rename file in current buffer
map('n', L('cr'), Snacks.rename.rename_file, '[C]ode [R]ename')
-- Delete buffer with snacks
map('n', L('bd'), Snacks.bufdelete.delete, '[B]uffer [D]elete')
map('n', L('bo'), Snacks.bufdelete.other, '[B]uffer [D]elete other')
map('n', L('ba'), Snacks.bufdelete.all, '[B]uffer [D]elete [A]ll')

-- Picker
-- Search things ==============================================================
map('n', L('sf'), Snacks.picker.files, 'Search files')
map('n', L('sm'), Snacks.picker.smart, 'Search files smart')
map('n', L('sw'), Snacks.picker.grep, 'Search word')
map('n', L('st'), Snacks.picker.colorschemes, 'Search colorschemes')
map('n', L('sr'), Snacks.picker.registers, 'Search registers')
map('n', L('sc'), Snacks.picker.commands, 'Search commands')
map('n', L('sh'), Snacks.picker.help, 'Search help')
map('n', L('sk'), Snacks.picker.keymaps, 'Search keymaps')
map('n', L('sb'), Snacks.picker.buffers, 'Search buffers')
map('n', L('sq'), Snacks.picker.qflist, 'Search quickfix list')
--- Find things ==============================================================
map('n', L('fc'), function()
  Snacks.picker.files({
    cwd = vim.fn.stdpath('config'),
  })
end, 'Find Config files')
map('n', L('fp'), Snacks.picker.projects, 'Find Projects')
map('n', L('fd'), Snacks.picker.diagnostics_buffer, 'Find Diagnostics in buffer')
map('n', L('fD'), Snacks.picker.diagnostics, 'Find Diagnostics')
map('n', L('fm'), Snacks.picker.marks, 'Find marks')
-- LSP =======================================================================
map('n', L('lr'), Snacks.picker.lsp_references, 'LSP references')
map('n', L('ld'), Snacks.picker.lsp_definitions, 'LSP definitions')
map('n', L('lt'), Snacks.picker.lsp_type_definitions, 'LSP type definitions')
map('n', L('li'), Snacks.picker.lsp_implementations, 'LSP implementations')
map('n', L('lD'), Snacks.picker.lsp_declarations, 'LSP declarations')
map('n', L('ls'), Snacks.picker.lsp_symbols, 'LSP symbols')
map('n', L('lS'), Snacks.picker.lsp_workspace_symbols, 'LSP workspace symbols')
