return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        fold_open = '',
        fold_closed = '',
        signs = {
            error = 'E',
            warning = 'W',
            hint = '?',
            information = 'I',
            other = 'O',
        },
    },
    keys = {
        { '<leader>xd',  '<CMD>Trouble document_diagnostics',     desc = "Document diagnostics" },
        { '<leader>xw',  '<CMD>Trouble workspace_diagnostics',    desc = "Workspace diagnostics" },
        { '<leader>gd',  '<CMD>Trouble lsp_definitions<CR>',      desc = '[G]o to [D]efinition' },
        { '<leader>gtd', '<CMD>Trouble lsp_type_definitions<CR>', desc = '[G]o to [T]ype [D]efinition' },
        { '<leader>gr',  '<CMD>Trouble lsp_references<CR>',       desc = '[G]o to [R]eferences' },
        { '<leader>gi',  '<CMD>Trouble lsp_implementations<CR>',  desc = '[G]o to [I]mplementations' },
    }
}
