vim.o.updatetime = 200
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
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.winbar = "%=%{fnamemodify(expand('%:p:h'), ':~')}"
vim.diagnostic.config({
  severity_sort = true,
  inlay_hints = {
    enabled = true,
  },
  float = { border = 'single', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 3,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
