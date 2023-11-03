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
    }
}
