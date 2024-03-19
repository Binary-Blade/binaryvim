return {
  'luisiacc/gruvbox-baby',
  enabled = false,
  config = function()
    vim.g.gruvbox_baby_background_color = 'dark'
    vim.cmd.colorscheme 'gruvbox-baby'
  end,
}
