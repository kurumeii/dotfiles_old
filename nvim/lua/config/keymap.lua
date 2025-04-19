local utils = require('utils')
local map, L, C = utils.map, utils.L, utils.C
-- MiniBracketed/Buffer remap
map('n', 'L', C('lua MiniBracketed.buffer("forward")'), 'Next buffer ->')
map('n', 'H', C('lua MiniBracketed.buffer("backward")'), 'Previous buffer <-')
map('n', L('bl'), C('lua MiniBracketed.buffer("last")'), '[B]uffer (L) ->>')
map('n', L('bh'), C('lua MiniBracketed.buffer("first")'), '[B]uffer (H) <<-')
map('n', L('bc'), C('lua MiniBufremove.delete(0)'), '[B]uffer [C]lose (x)')
map(
  'n',
  L('bw'),
  C('lua MiniBufremove.wipeout()'),
  '[B]uffer [W]ipeout (x-all)'
)
-- MiniPick/ Picker
map('n', L('sf'), C('lua MiniPick.builtin.files()'), '[S]earch [F]iles')
map('n', L('sw'), C('lua MiniPick.builtin.grep_live()'), '[S]earch [W]ord')
map('n', L('st'), C('Pick colorschemes'), '[S]earch [T]heme')
map('n', L('sr'), C('Pick registers'), '[S]earch [R]egistry')
map('n', L('sc'), C('Pick commands'), '[S]earch [C]ommands')
map('n', L('sh'), C('Pick help'), '[S]earch [H]elp')
map('n', L('sb'), C('lua MiniPick.builtin.buffers()'), '[S]earch [B]uffer')

-- Qol remap
map('n', '<Esc>', C('nohlsearch'))
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

map('n', L('nd'), C('lua MiniNotify.clear()'), '[N]otify: [D]ismiss all')
map({ 'n' }, [[\f]], C('FormatToggle'), 'Toggle auto-format')

-- map(
--   { 'n' },
--   L('gg'),
--   C("lua require('plugins.customs.toggleterm').lazygit_toggle()"),
--   'Toggle Lazygit'
-- )

-- Fold
-- map(
-- 	'n',
-- 	'K',
-- 	C 'lua if not ufo.peekFoldedLinesUnderCursor() then vim.lsp.buf.hover()',
-- 	'Peak inside'
-- )

-- Sessions
map(
  { 'n' },
  L('Ss'),
  C("lua require('plugins.mini.sessions').save()"),
  'Save session'
)
map(
  { 'n' },
  L('Sd'),
  C("lua require('plugins.mini.sessions').delete()"),
  'Delete session'
)
map({ 'n' }, L('Sl'), C('lua MiniSessions.select()'), 'Load session')

-- LSP
map('n', L('lr'), C('Pick lsp scope="references"'), '[L]sp: [R]efrences')
map('n', L('ld'), C('Pick lsp scope="definition"'), '[L]sp: [D]efinition')
map('n', L('lD'), C('Pick lsp scope="declaration"'), '[L]sp: [D]eclaration')
map(
  'n',
  L('li'),
  C('Pick lsp scope ="implementation"'),
  '[L]sp: [I]mplementation'
)
map('n', L('lR'), C('LspRestart'), '[L]sp: [R]eset Server')
map('n', L('ca'), C('lua vim.lsp.buf.code_action()'), '[C]ode [A]ction')
map(
  { 'n' },
  L('cd'),
  C('lua vim.diagnostic.open_float()'),
  '[C]ode show [D]iagnostic'
)
map('n', L('cf'), C('lua require "conform".format()'), '[C]ode [F]ormat')
map('n', L('cr'), C('lua vim.lsp.buf.rename()'), '[C]ode [R]ename')
