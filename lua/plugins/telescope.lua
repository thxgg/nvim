return {
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
        { "<leader>ff", ":Telescope find_files<CR>", desc = "[F]ind [F]iles" },
        { "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>", desc = "[F]ind [B]uffer" },
        { "<leader>/", ":Telescope live_grep<CR>", desc = "Search" },
        { "<leader>fg", ":Telescope grep_string<CR>", desc = "[F]ind [G]rep" },
        -- Diagnostics
        { "<leader>x", ":Telescope diagnostics<CR>", desc = "Diagnostics" },
        { "<leader>xb", ":Telescope diagnostics bufnr=0<CR>", desc = "Diagnostics for document" },
        -- LSP
        { "<leader>gd", ":Telescope lsp_definitions<CR>", desc = "[G]o to [D]efinition" },
        { "<leader>gt", ":Telescope lsp_type_definitions<CR>", desc = "[G]o to [T]ype Definition" },
        { "<leader>gr", ":Telescope lsp_references<CR>", desc = "[G]o to [R]eferences" },
        { "<leader>gi", ":Telescope lsp_implementations<CR>", desc = "[G]o to [I]mplementations" },
        -- Git
        { "<leader>gs", ":Telescope git_status<CR>", desc = "[G]it [S]tatus" },
        { "<leader>gb", ":Telescope git_branches<CR>", desc = "[G]it [B]ranches" },
        { "<leader>gc", ":Telescope git_commits<CR>", desc = "[G]it [C]ommits" },
        { "<leader>gC", ":Telescope git_bcommits<CR>", desc = "Git buffer commits" },
        -- Util
        { "<leader>h", ":Telescope help_tags<CR>", desc = "[H]elp" },
        { "<leader>,", ":Telescope keymaps<CR>", desc = "Keymaps" },
        { "<leader>.", ":Telescope vim_options<CR>", desc = "Options" },
        { "<leader>cs", ":Telescope colorscheme<CR>", desc = "[C]olor[s]cheme" },
    }
}
