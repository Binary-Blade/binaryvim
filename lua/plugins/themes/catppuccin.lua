return {
  'catppuccin/nvim',
  name = 'catppuccin-mocha',
  priority = 1000,
  enabled = true,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      --transparent_background = true,
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
    -- You can configure highlights by doing something like
    --vim.cmd.hi 'Comment gui=none'
  end,
}
