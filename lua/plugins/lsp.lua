local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = true
    opts.silent = true
    vim.keymap.set(mode, lhs, rhs, opts)
end

local on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspAutoformat', { clear = true }),
        callback = function() vim.lsp.buf.format() end
    })

    map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Show tooltip' })
    map('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Show signature help' })
    map('n', '<F2>', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
    map('n', '<F3>', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format buffer' })
    map('n', '<F4>', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp'
        }
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        opts = {
            ensure_installed = {
                'bashls',
                'clangd',
                'cssls',
                'dockerls',
                'docker_compose_language_service',
                'emmet_language_server',
                'eslint',
                'gopls',
                'gradle_ls',
                'html',
                'jdtls',
                'lemminx',
                'lua_ls',
                'marksman',
                'rust_analyzer',
                'sqlls',
                'tailwindcss',
                'templ',
                'tsserver',
                'volar'
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        on_attach = on_attach,
                        capabilities = require('cmp_nvim_lsp').default_capabilities()
                    })
                end,
                eslint = function()
                    require('lspconfig').eslint.setup({
                        on_attach = function(client, bufnr)
                            on_attach(client, bufnr)
                            vim.api.nvim_create_autocmd('BufWritePre', {
                                buffer = bufnr,
                                command = 'EslintFixAll',
                            })
                        end,
                        capabilities = require('cmp_nvim_lsp').default_capabilities()
                    })
                end,
                jdtls = function() end,
                ['lua_ls'] = function()
                    require('lspconfig').lua_ls.setup({
                        on_attach = on_attach,
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                }
                            }
                        }
                    })
                end,
                volar = function()
                    require('lspconfig').volar.setup({
                        on_attach = on_attach,
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
                    })
                end,
            }
        }
    },
    {
        'williamboman/mason.nvim',
        opts = {}
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim'
        },
        opts = function(_, opts)
            local cmp = require('cmp')

            opts.snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            }
            opts.mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-y>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false
                }),
                ['<C-space>'] = cmp.mapping.complete(),
            }
            opts.formatting = {
                format = require('lspkind').cmp_format({
                    mode = 'symbol',
                    menu = {
                        buffer = '[Buf]',
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[API]',
                        path = '[Path]',
                        luasnip = '[Snip]',
                    },
                })
            }
            opts.sources = {
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
