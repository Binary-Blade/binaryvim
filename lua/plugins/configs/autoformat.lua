-- Autoformat
return {
  -- TODO: IMPLEMENT LATER
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { { 'prettierd', 'prettier' } },

      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
    },
  },
}
