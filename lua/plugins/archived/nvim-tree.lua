return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    vim.opt.termguicolors = true
    require('nvim-tree').setup {
      -- sort = {
      --   sorter = 'case_sensitive',
      -- },
      -- view = {
      --   width = 30,
      -- },
      -- renderer = {
      --   group_empty = true,
      -- },
      -- filters = {
      --   dotfiles = true,
      -- },
      diagnostics = {
        enable = true,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        },
      },
    }
  end,
  -- Nvim-tree
  vim.keymap.set('n', '<leader>e', '<CMD>:NvimTreeToggle<CR>', { desc = 'Open NvimTre[E]' }, { noremap = true, silent = true }),
}
