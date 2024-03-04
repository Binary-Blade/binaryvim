return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local function lsp_status()
      local msg = 'No Active Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'palenight',
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
        lualine_a = {
          {
            'fileformat',
            symbols = {
              unix = '', -- e712
            },
          },
          'mode',
        },
        lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = '', -- Icon for modified files
              readonly = '', -- Icon for read-only files
              unnamed = '', -- Icon for unnamed buffers
              newfile = '', -- Icon for new files
            },
          },
        },
        lualine_x = {
          { lsp_status, icon = ' LSP:' },
          {
            'filetype',
            colored = true, -- Displays filetype icon in color if set to true
            icon_only = false, -- Display only an icon for filetype
            icon = { align = 'right' }, -- Display filetype icon on the right hand side
            -- icon =    {'X', align='right'}
            -- Icon string ^ in table is ignored in filetype component
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {},
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
