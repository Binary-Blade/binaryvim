return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with {
          filetypes = { 'javascript', 'typescript', 'css', 'html', 'json', 'vue' },
        },
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
      },
    }
  end,
}
