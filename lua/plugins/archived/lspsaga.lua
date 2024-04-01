return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup {
      ui = {
        code_action = '',
      },
    }
  end,
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
