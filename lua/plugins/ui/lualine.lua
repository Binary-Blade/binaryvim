return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local function mode_icon()
      local mode_map = {
        ['n'] = ' ', -- Icon for Normal mode
        ['i'] = ' ', -- Icon for Insert mode
        ['V'] = '󰅩 ', -- Icon for Visual mode
        ['v'] = '󰘦 ', -- Icon for V-Line mode
        ['R'] = '凜 ', -- Icon for Replace mode
        ['c'] = ' ', -- Icon for Command mode
        -- Add more modes as needed
      }
      local mode = vim.api.nvim_get_mode().mode
      return mode_map[mode] or mode -- Fallback to mode letter if no icon defined
    end

    local function lsp_status()
      local msg = '󰟢 LSP active' -- Default icon when no LSP is active
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end

      -- Mapping from LSP server name to icon
      local lsp_icons = {
        ['intelephense'] = ' ', -- Replace with your chosen PHP icon
        ['tsserver'] = '󰛦 ', -- Replace with your chosen TypeScript icon
        ['volar'] = ' ', -- Replace with your chosen Vue icon
        ['lua_ls'] = '󰢱 ',
        ['clangd'] = ' ', -- Replace with your chosen C/C++ icon
        ['yamlls'] = '󰍛 ', -- Replace with your chosen YAML icon
        ['dockerls'] = '󰡨 ', -- Replace with your chosen Docker icon
      }

      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          -- Return the LSP server's icon and name if defined, otherwise just the name
          local icon = lsp_icons[client.name] or ''
          return icon .. ' ' .. client.name
        end
      end
      return msg
    end
    require('lualine').setup {
      options = {
        theme = 'palenight',
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        always_divide_middle = false,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { { mode_icon, separator = { left = '', right = '' } } },
        lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        lualine_c = {
          {

            symbols = {
              modified = '󰔯', -- Icon for modified files
              readonly = '', -- Icon for read-only files
              unnamed = '', -- Icon for unnamed buffers
              newfile = '', -- Icon for new files
            },
          },
        },
        lualine_x = {
          { lsp_status, color = { fg = '#ffeead' } },
          {
            'filetype',
            colored = true,            -- Displays filetype icon in color if set to true
            icon_only = false,         -- Display only an icon for filetype
            icon = { align = 'left' }, -- Display filetype icon on the right hand side
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { { 'filename', path = 1, shorting_target = 40 } },
      },
      inactive_sections = {},
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
