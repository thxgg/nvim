return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'gruvbox-material',
            section_separators = '',
            component_separators = {
                left = '|',
                right = '|',
            },
            globalstatus = true,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'filename', 'diagnostics' },
            lualine_c = { 'aerial' },
            lualine_x = { { 'fileformat', symbols = { unix = 'lf', dos = 'crlf', mac = 'cr' } },
                { 'filetype',   icons_enabled = false } },
            lualine_y = { { 'diff' } },
            lualine_z = { { 'b:gitsigns_head', icon = '' } }
        },
        tabline = {
            lualine_a = { { 'buffers', icons_enabled = false, symbols = '' } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = { require("copilot_status").status_string },
            lualine_z = { { 'tabs', symbols = '' } }
        },
        extensions = { 'aerial', 'lazy', 'nvim-dap-ui', 'mason', 'trouble' },
    }
}
