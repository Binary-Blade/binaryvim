return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensured_installed = {
          'tsserver',
          'volar',
          'clangd',
          'clang-format',
          'codelldb',
          'intelephense',
          'lua_ls',
        },
        automatic_servers = true,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }
        -- key_map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        --   key_map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        --   key_map('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        --   key_map('<leader>gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        --   key_map('<leader>gT', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype [D]efinition')
        --   key_map('<leader>fd', require('telescope.builtin').lsp_document_symbols, '[F]ind [D]ocument Symbols')
        --   key_map('<leader>fw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[F]ind [W]orkspace Symbols')
        --   key_map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
        --   key_map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        --   key_map('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- Add more mappings as needed

        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end

      -- LSP server configurations
      local servers = {
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
        tsserver = {
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        },
        clangd = {},
        intelephense = {
          settings = {
            intelephense = {
              filetypes = { 'php', 'blade' },
              files = {
                associations = { '*.php', '*.blade.php' },
                maxSize = 5000000,
              },
            },
          },
        },
        volar = {},
      }

      -- Setup LSP servers
      for server, config in pairs(servers) do
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    end,
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

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

  },
}
