return {
  'catppuccin/nvim',
  name = 'catppuccin-mocha',
  enabled = true,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
    }
    vim.cmd.colorscheme 'catppuccin'
    -- You can configure highlights by doing something like
    vim.cmd.hi 'Comment gui=none'
  end,
}
