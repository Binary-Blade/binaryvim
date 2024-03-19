return {
  'ramojus/mellifluous.nvim',
  enabled = false,
  config = function()
    require('mellifluous').setup {
      -- transparent_background = {
      --   enabled = true,
      --   floating_windows = true,
      --   telescope = true,
      --   file_tree = true,
      --   cursor_line = true,
      --   status_line = false,
      -- },
    }
    vim.cmd [[colorscheme mellifluous]]
  end,
}
