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

    local servers = {
      -- TS/JS
      tsserver = {},
      volar = {},
      angularls = {},
      -- Python
      pyright = {},
      -- Rust & C
      rust_analyzer = {},
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

    require('mason').setup()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'clangd',
      'clang-format',
      'codelldb',
      'pyright',
      'intelephense',
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          require('lspconfig')[server_name].setup {
            cmd = server.cmd,
            settings = server.settings,
            filetypes = server.filetypes,
            capabilities = capabilities,
          }
        end,
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local key_map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        key_map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        key_map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        key_map('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        key_map('<leader>gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        key_map('<leader>gT', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype [D]efinition')
        key_map('<leader>fd', require('telescope.builtin').lsp_document_symbols, '[F]ind [D]ocument Symbols')
        key_map('<leader>fw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[F]ind [W]orkspace Symbols')
        key_map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
        key_map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
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
