return {
  'rose-pine/neovim',
  name = 'rose-pine',
  enabled = false,
  config = function()
    require('rose-pine').setup {
      variant = 'main',
      dark_variant = 'main',
      styles = {
        transparency = false,
      },
    }
    vim.cmd [[colorscheme rose-pine]]
  end,
}
