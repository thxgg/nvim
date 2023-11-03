return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'zbirenbaum/copilot-cmp'
        },
        opts = function(_, opts)
            local cmp = require('cmp')

            opts.snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            }
            opts.mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-y>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false
                }),
                ['<C-Space>'] = cmp.mapping.complete(),
            })
            opts.formatting = {
                format = require('lspkind').cmp_format({
                    mode = 'symbol',
                    menu = {
                        buffer = '[Buf]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[API]',
                        path = '[Path]',
                        luasnip = '[Snip]',
                        copilot = '[Copilot]'
                    },
                    symbol_map = { Copilot = '' },
                })
            }
            opts.sources = {
                { name = 'copilot' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'buffer' },
            }
            opts.experimental = {
                native_menu = false,
                ghost_text = true,
            }
        end
    },
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = { 'L3MON4D3/LuaSnip' }
    },
}
