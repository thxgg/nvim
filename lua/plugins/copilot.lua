return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		build = { ":Copilot authi", ":Copilot disable" },
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		keys = {
			{ "<leader>cpt", "<CMD>Copilot toggle<CR>", desc = "[T]oggle [C]o[p]ilot" },
		},
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		lazy = true,
		event = "BufReadPost",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {
			icons = {
				idle = "",
				error = "",
				offline = "",
				warning = "",
				loading = "",
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = true,
	},
}
