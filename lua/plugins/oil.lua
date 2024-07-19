return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    delete_to_trash = true,
  },
  keys = {
    { "<leader>e", "<CMD>Oil<CR>", desc = "Open File [E]xplorer" },
  },
}
