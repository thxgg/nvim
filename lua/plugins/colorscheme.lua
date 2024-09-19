return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.opt.background = 'dark'
      -- vim.g.gruvbox_material_better_performance = 1
      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "cool",
    },
    config = function(_, opts)
      -- require('onedark').setup(opts)
      --
      -- vim.opt.background = 'dark'
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        mason = true,
        neotest = true,
        lsp_trouble = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      vim.opt.background = "dark"
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
