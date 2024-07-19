return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fold_open = "",
    fold_closed = "",
    signs = {
      error = "E",
      warning = "W",
      hint = "?",
      information = "I",
      other = "O",
    },
  },
  keys = {
    { "<leader>xd",  "<CMD>Trouble diagnostics<CR>",         desc = "Diagnostics" },
    { "<leader>gd",  vim.lsp.buf.definition,                 desc = "[G]o to [D]efinition" },
    { "<leader>gtd", vim.lsp.buf.type_definitions,           desc = "[G]o to [T]ype [D]efinition" },
    { "<leader>gr",  "<CMD>Trouble lsp_references<CR>",      desc = "[G]o to [R]eferences" },
    { "<leader>gi",  "<CMD>Trouble lsp_implementations<CR>", desc = "[G]o to [I]mplementations" },
  },
}
