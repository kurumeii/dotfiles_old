local utils = require('utils')
local map, L, C = utils.map, utils.L, utils.C
-- Qol remap
map('n', '<Esc>', C('nohlsearch'))
map('n', L'cs', C('source'), 'Code source current')
map('n', L('wqq'), C('q'), '[W]indow [Q]uit')
map('n', L('wqa'), C('qa'), '[W]indow [Q]uit [A]ll')
map('n', L('ww'), C('w'), '[W]indow [W]rite')
map('n', L('wa'), C('wa'), '[W]indow [W]rite [A]ll')
map('n', L('wsl'), C('vsplit'), '[W]indow [S]plit [L]eft')
map('n', L('wsd'), C('split'), '[W]indow [S]plit [D]own')
map('n', L('wrj'), C('resize +5'), '[W]indow [R]esize down')
map('n', L('wrk'), C('resize -5'), '[W]indow [R]esize up')
map('n', L('wrh'), C('vertical resize +5'), '[W]indow [R]esize right')
map('n', L('wrl'), C('vertical resize -5'), '[W]indow [R]esize left')
map('n', L('wrr'), C('<c-w>='), '[W]indow [R]esize [R]eset')
map('n', ']t', C('tabnext'), 'Next tab')
map('n', '[t', C('tabprev'), 'Previous tab')
map('n', '<c-a>', 'ggVG', 'Visual select all', {
  noremap = true,
})

map({ 'n' }, [[\f]], C('FormatToggle'), 'Toggle auto-format')
