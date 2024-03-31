return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.opt.background = 'dark'
            -- vim.g.gruvbox_material_better_performance = 1
            -- vim.cmd.colorscheme 'gruvbox-material'
        end
    },
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'cool',
        },
        config = function(_, opts)
            require('onedark').setup(opts)

            vim.opt.background = 'dark'
            vim.cmd.colorscheme 'onedark'
        end
    }
}
