return {
  'mfussenegger/nvim-dap',
  config = function(_, _)
    require('core.keymaps').debugger_keymaps()
  end,
}
