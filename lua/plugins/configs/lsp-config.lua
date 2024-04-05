return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Define the configuration for LSP servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    require('mason').setup()

    -- Want to desactive import diagnostics
    local servers = {
      tsserver = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = '/opt/homebrew/lib/node_modules/@vue/language-server',
              languages = { 'vue' },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      },
      volar = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
      -- C
      clangd = {},
      -- PHP
      intelephense = {
        filetypes = { 'php', 'blade' },
        settings = {
          intelephense = {
            filetypes = { 'php', 'blade' },
            files = {
              associations = { '*.php', '*.blade.php' }, -- Associating .blade.php files as well
              maxSize = 5000000,
            },
          },
        },
      },
      -- LUA
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Configure each LSP server
    for server_name, config in pairs(servers) do
      require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', {
        capabilities = capabilities,
      }, config))
    end

    -- Ensure the specified LSP servers are installed
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local key_map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        key_map('<leader>ld', require('telescope.builtin').lsp_definitions, '[D]efinition')
        key_map('<leader>lr', require('telescope.builtin').lsp_references, '[R]eferences')
        key_map('<leader>li', require('telescope.builtin').lsp_implementations, '[I]mplementation')
        key_map('<leader>lt', require('telescope.builtin').lsp_type_definitions, '[T]ype Definition')
        key_map('<leader>lf', require('telescope.builtin').lsp_document_symbols, '[F]ind Symbols')
        key_map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
        key_map('<leader>lc', vim.lsp.buf.code_action, '[C]ode Action')
        key_map('<leader>lR', vim.lsp.buf.rename, '[R]ename')
        key_map('K', vim.lsp.buf.hover, 'Hover Documentation')

        --    See `:help CursorHold` for information about when this is executed
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
