return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		fold_open = "",
		fold_closed = "",
		signs = {
			error = "E",
			warning = "W",
			hint = "H",
			information = "I",
			other = "O",
		},
	},
	keys = {
		{ "<leader>xd", "<CMD>Trouble diagnostics<CR>", desc = "Diagnostics" },
		{ "<leader>gd", vim.lsp.buf.definition, desc = "[G]o to [D]efinition" },
		{ "<leader>gtd", vim.lsp.buf.type_definitions, desc = "[G]o to [T]ype [D]efinition" },
		{ "<leader>gr", vim.lsp.buf.references, desc = "[G]o to [R]eferences" },
		{ "<leader>gi", vim.lsp.buf.implementation, desc = "[G]o to [I]mplementations" },
	},
}
