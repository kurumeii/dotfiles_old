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
    lua = { 'stylua' },
    markdown = { 'markdownlint' },
    javascript = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    javascriptreact = { 'biome' },
  },
  formatters = {
    biome = {
      command = 'biome',
      args = { 'check', '--write', '--stdin-file-path', '$FILENAME' },
      stdin = true,
    },
  },
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
