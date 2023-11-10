return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            },
        },
        keys = {
            -- Search
            { '<leader>ff', '<CMD>Telescope find_files<CR>',                desc = '[F]ind [F]iles' },
            { '<leader>fb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', desc = '[F]ind in [B]uffer' },
            { '<leader>/',  '<CMD>Telescope live_grep<CR>',                 desc = 'Search' },
            { '<leader>fg', '<CMD>Telescope grep_string<CR>',               desc = '[F]ind [G]rep' },
            -- Git
            { '<leader>gs', '<CMD>Telescope git_status<CR>',                desc = '[G]it [S]tatus' },
            { '<leader>gb', '<CMD>Telescope git_branches<CR>',              desc = '[G]it [B]ranches' },
            { '<leader>gc', '<CMD>Telescope git_commits<CR>',               desc = '[G]it [C]ommits' },
            { '<leader>gC', '<CMD>Telescope git_bcommits<CR>',              desc = 'Git commits buffer' },
            -- Util
            { '<leader>?',  '<CMD>Telescope help_tags<CR>',                 desc = 'Help' },
            { '<leader>,',  '<CMD>Telescope keymaps<CR>',                   desc = 'Keymaps' },
            { '<leader>.',  '<CMD>Telescope vim_options<CR>',               desc = 'Options' },
            { '<leader>cs', '<CMD>Telescope colorscheme<CR>',               desc = '[C]olor[s]cheme' },
        }
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require('telescope').load_extension('ui-select')
        end,
    }
}
