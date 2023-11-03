local opt = vim.opt

opt.backup = false
opt.breakat = " \t!@*-+;:,./?"
opt.breakindent = true
opt.breakindentopt = 'shift:2,sbr'
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "both"
opt.expandtab = true
opt.guicursor = ""
opt.hlsearch = false
opt.incsearch = true
opt.isfname:append("@-@")
opt.linebreak = true
opt.list = true
opt.listchars = "tab:» ,eol:↲,trail:-"
opt.number = true
opt.relativenumber = false
opt.scrolloff = 8
opt.shiftwidth = 4
opt.showbreak = '↳'
opt.signcolumn = "yes"
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.wrap = true
opt.wrapmargin = 2

-- Right click mouse menu
vim.cmd.aunmenu{'PopUp.How-to\\ disable\\ mouse'}
vim.cmd.aunmenu{'PopUp.-1-'}
