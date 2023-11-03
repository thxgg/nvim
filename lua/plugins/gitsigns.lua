return {
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '-' },
            topdelete    = { text = '-' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']g', function()
                if vim.wo.diff then return ']g' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '[g', function()
                if vim.wo.diff then return '[g' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            -- Actions
            map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = '[G]it [B]lame' })
            map('n', '<leader>gD', gs.diffthis, { desc = '[G]it [D]iff' })
        end
    }
}
