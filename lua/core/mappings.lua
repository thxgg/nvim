local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = mode ~= "t"
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

-- Human error correction
map("n", "W", ":w<CR>", { desc = "[W]rite Buffer" })
map("n", "Q", ":q<CR>", { desc = "[Q]uit Buffer" })
map("n", "Qa", ":qa<CR>", { desc = "[Q]uit [A]ll Buffers" })
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Bd", "bd", {})

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease size by 2" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase size by 2" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease vertical size by 2" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase vertical size by 2" })

-- Navigation
map("n", "H", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "L", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<C-d>", "<C-d>zz", { desc = "Recenter cursor after half-page jumping down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Recenter cursor after half-page jumping up" })
map("n", "<C-h>", "<C-w>h", { desc = "Jump to the window to the left" })
map("n", "<C-j>", "<C-w>j", { desc = "Jump to the window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Jump to the window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Jump to the window to the right" })
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Jump to the window to the left" })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Jump to the window below" })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Jump to the window above" })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Jump to the window to the right" })

-- Selection manipulation
map("v", "<", "<gv", { desc = "Outdent selection" })
map("v", ">", ">gv", { desc = "Indent selection" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Line manipulation
map("n", "J", "mzJ`z", { desc = "Append line below with a space without moving cursor" })

-- Search
map("n", "n", "nzzzv", { desc = "Recenter cursor after next lookup" })
map("n", "N", "Nzzzv", { desc = "Recenter cursor after previous lookup" })
