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
    { 'mfussenegger/nvim-jdtls' },
}
