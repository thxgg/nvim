return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = false,
    view_options = {
      is_hidden_file = function(name)
        -- Rule 1: Show files matching specific name
        local show_by_name = {
          ".gitignore",
          ".editorconfig",
        }

        for _, shown_name in ipairs(show_by_name) do
          if name == shown_name then
            return false
          end
        end

        -- Rule 2: Show files matching specific patterns
        local show_by_pattern = {
          "%.env.*",
          "application.*%.properties",
        }

        for _, pattern in ipairs(show_by_pattern) do
          if string.match(name, pattern) then
            return false
          end
        end

        return vim.startswith(name, ".")
      end,
    },
  },
  keys = {
    { "<leader>e", "<CMD>Oil<CR>", desc = "Open File [E]xplorer" },
  },
}
