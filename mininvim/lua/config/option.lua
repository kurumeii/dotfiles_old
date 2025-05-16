vim.o.updatetime = 200
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.colorscheme = 'astrotheme'
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
vim.o.laststatus = 2
-- vim.o.showcmd = false
-- vim.o.showcmdloc = 'statusline'
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorline = true
vim.o.confirm = true
vim.o.mouse = 'a'
vim.o.formatoptions = 'jcroqlnt' -- tcqj
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.clipboard = 'unnamedplus'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.scrolloff = 10
vim.o.swapfile = false
-- vim.o.backup = false
vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'single', source = 'if_many' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = mininvim.icons.error,
      [vim.diagnostic.severity.WARN] = mininvim.icons.warn,
      [vim.diagnostic.severity.INFO] = mininvim.icons.info,
      [vim.diagnostic.severity.HINT] = mininvim.icons.hint,
    },
  },
  virtual_text = {
    spacing = 4,
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
