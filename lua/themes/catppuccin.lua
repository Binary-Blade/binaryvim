return {
  'catppuccin/nvim',
  name = 'catppuccin-mocha',
  enabled = true,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,

      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
    -- You can configure highlights by doing something like
    --vim.cmd.hi 'Comment gui=none'
  end,
}
