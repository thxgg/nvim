return {
    'stevearc/aerial.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    opts = {},
    keys = {
        { 'n', '<leader>co', '<CMD>AerialToggle!<CR>', desc = '[C]ode [O]utline' }
    }
}
