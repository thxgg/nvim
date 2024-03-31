return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        disable_netrw = true,
        view = {
            side = 'right',
            adaptive_size = true
        },
        renderer = {
            icons = {
                web_devicons = {
                    folder = {
                        enable = false,
                    },
                },
                symlink_arrow = '  ',
                glyphs = {
                    default = '',
                    symlink = '',
                    bookmark = '',
                    modified = '',
                    folder = {
                        arrow_closed = '',
                        arrow_open = '',
                        default = '',
                        open = '',
                        empty = '',
                        empty_open = '',
                        symlink = '',
                        symlink_open = '',
                    },
                    git = {
                        unstaged = '',
                        staged = '',
                        unmerged = '',
                        renamed = '',
                        untracked = '',
                        deleted = '󰆴',
                        ignored = '',
                    },
                },
            }
        },
        update_focused_file = {
            enable = true,
        },
        filters = {
            custom = { '^.git$' },
            exclude = { '.env.*' }
        },
    },
    config = function(_, opts)
        require('nvim-tree').setup(opts)

        local smartToggleTree = function()
            local nvimTree = require('nvim-tree.api')
            local currentBuf = vim.api.nvim_get_current_buf()
            local currentBufFt = vim.api.nvim_get_option_value('filetype', { buf = currentBuf })
            if currentBufFt == 'NvimTree' then
                nvimTree.tree.toggle()
            else
                nvimTree.tree.focus()
            end
        end

        vim.keymap.set('n', '<leader>e', smartToggleTree, { desc = 'File [E]xplorer', silent = true, noremap = true })
    end
}
