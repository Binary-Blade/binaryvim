-- Highlight todo, notes, etc in comments
--
-- TODO: Configure it
return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
  },
}
