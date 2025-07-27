vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  desc = 'Supermaven: Lazy init',
  callback = function(args)
    local utils = require('utils')
    local helper = {
      api = require('supermaven-nvim.api'),
      main = require('supermaven-nvim'),
    }
    if not helper.api.is_running() then
      helper.main.setup({
        keymaps = {
          accept_suggestion = '<Tab>',
          clear_suggestion = '<C-c>',
          accept_word = '<c-j>',
        },
      })
    end

    utils.map(
      { 'n' },
      utils.L('xat'),
      function()
        if helper.api.is_running() then
          helper.api.stop()
          utils.notify('Supermaven is now disabled', 'WARN')
        else
          helper.api.start()
          utils.notify('Supermaven is now running', 'WARN')
        end
      end,
      'Code: toggle supermaven',
      {
        buffer = args.buf,
      }
    )
  end,
})
