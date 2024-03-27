return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').setup()
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ebugger', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]oto', _ = 'which_key_ignore' },
      ['<leader>o'] = { name = '[O]bsidian', _ = 'which_key_ignore' },
      ['<leader>q'] = { name = '[Q]uick', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]esting', _ = 'which_key_ignore' },
      ['<leader>v'] = { name = '[V]irtual', _ = 'which_key_ignore' },
    }
  end,
}
