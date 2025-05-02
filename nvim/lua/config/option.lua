vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.shell = 'pwsh.exe'
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.breakindent = true
vim.o.inccommand = 'nosplit'
vim.o.foldlevel = 99 -- Necessary
vim.o.foldlevelstart = 99
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cmdheight = 0
vim.o.showcmd = false
vim.o.showcmdloc = 'statusline'
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.confirm = true
vim.o.mouse = ''
vim.o.formatoptions = 'jcroqlnt' -- tcqj
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
-- Sync with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.scrolloff = 10
vim.o.swapfile = false
-- vim.o.backup = false
-- vim.o.winbar = "%=%{fnamemodify(expand('%:p:h'), ':~')}"
