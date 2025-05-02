MiniDeps.add({
  source = 'stevearc/conform.nvim',
})

require('conform').setup({
  notify_on_error = true,
  -- format_after_save = function(bufnr)
  --   if vim.g.disable_autoformat then
  --     return
  --   end
  --   return {
  --     timeout_ms = 1000,
  --     lsp_format = "fallback",
  --   }
  -- end,
  formatters_by_ft = {
		markdown = {'markdownlint'},
    lua = { 'stylua' },
    javascript = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    javascriptreact = { 'biome' },
  },
  formatters = {},
})

-- Conform

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format({ bufnr = args.buf, async = true })
  end,
})

-- vim.api.nvim_create_user_command("FormatToggle", function(_)
--   vim.g.disable_autoformat = not vim.g.disable_autoformat
--   local state = vim.g.disable_autoformat and "disabled" or "enabled"
--   vim.notify("Auto-save " .. state)
-- end, {
--   desc = "Toggle autoformat-on-save",
--   bang = true,
-- })
--
local utils = require('utils')
local map, L = utils.map, utils.L

map('n', L('cf'), function() vim.cmd('lua require "conform".format({ async = true})') end, '[C]ode [F]ormat')
map('n', L('ca'), function() vim.cmd('lua vim.lsp.buf.code_action()') end, '[C]ode [A]ction')
map({ 'n' }, L('cd'), function() vim.cmd('lua vim.diagnostic.open_float()') end, '[C]ode show [D]iagnostic')
-- map('n', L('cr'), function() vim.cmd('lua vim.lsp.buf.rename()') end, '[C]ode [R]ename')
