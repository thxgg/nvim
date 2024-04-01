return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            { 'windwp/nvim-ts-autotag' },
        },
        config = function()
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = {
                    -- Recommended languages
                    'c', 'lua', 'vim', 'vimdoc', 'query',
                    -- Git
                    'diff',
                    'git_config',
                    'git_rebase',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    -- Config
                    'dockerfile',
                    'gpg',
                    'ssh_config',
                    'toml',
                    'yaml',
                    -- Documentation
                    'latex',
                    'markdown',
                    'markdown_inline',
                    -- Frontend
                    'css',
                    'html',
                    'javascript',
                    'scss',
                    'tsx',
                    'typescript',
                    'vue',
                    -- Backend
                    'bash',
                    'go',
                    'gomod',
                    'gosum',
                    'gowork',
                    'groovy',
                    'java',
                    'rust',
                    'sql'
                },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                autotag = {
                    enable = true
                }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    }
}
