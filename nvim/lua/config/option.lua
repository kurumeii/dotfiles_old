vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.shell = 'pwsh.exe'
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.breakindent = true
vim.o.inccommand = 'nosplit'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cmdheight = 1
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.confirm = true
vim.o.mouse = ''
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = '1'
vim.o.smoothscroll = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
vim.o.formatoptions = 'jcroqlnt' -- tcqj
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
-- Sync with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
