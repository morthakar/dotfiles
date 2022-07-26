local augroup = vim.api.nvim_create_augroup
DrefGroup = augroup('Dref', {})
local yank_group = augroup('HighlightYank', {})

local autocmd = vim.api.nvim_create_autocmd

-- Fast Yank highlight
autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

-- Remove blank space on save
autocmd({ "BufWritePre" }, {
	group = DrefGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Options
vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.errorbells = false
vim.opt.guicursor = "a:"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = false

-- Keybinds
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true })
vim.keymap.set("n", "<C-Left>", ":bprev<CR>", { noremap = true })
vim.keymap.set("n", "<C-Right>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true }) -- Scroll down
vim.keymap.set("n", "<C-e>", ":Ex<CR>", { noremap = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true }) -- Save
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true }) -- Scroll up
vim.keymap.set("n", "J", "mzJ`z", { noremap = true }) -- Move line up
vim.keymap.set("n", "N", "Nzzzv", { noremap = true }) -- Back search and centralize
vim.keymap.set("n", "Q", "<nop>", { noremap = true })
vim.keymap.set("n", "Y", "yg$", { noremap = true }) -- Yankee cursor to end of line
vim.keymap.set("n", "n", "nzzzv", { noremap = true }) -- Next and centralize
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true }) -- Move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true }) -- Move selection up

-- Telescope
vim.keymap.set("n", "<leader><F1>", "<cmd>Telescope help_tags<CR>", { noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { noremap = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { noremap = true })
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { noremap = true })
