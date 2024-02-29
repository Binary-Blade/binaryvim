local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require 'core.settings'

-- [[ Configure and install plugins ]]
require('lazy').setup {
  spec = {
    { import = 'themes' },
    { import = 'lsp' },
    { import = 'plugins' },
    { import = 'plugins.configs' },
    { import = 'plugins.utils' },
    { import = 'plugins.navigation' },
  },
}
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
