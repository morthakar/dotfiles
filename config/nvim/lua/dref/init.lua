local augroup = vim.api.nvim_create_augroup
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
local opts = { noremap = true }
vim.keymap.set("i", "<C-c>", "<Esc>", opts)
vim.keymap.set("n", "<C-Left>", "<cmd>bprev<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<CR>", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- Scroll down
vim.keymap.set("n", "<C-e>", "<cmd>Ex<CR>", opts)
vim.keymap.set("n", "<C-f>", "/", opts)
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", opts) -- Save
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts) -- Scroll up
vim.keymap.set("n", "J", "mzJ`z", opts) -- Move line up
vim.keymap.set("n", "N", "Nzzzv", opts) -- Back search and centralize
vim.keymap.set("n", "Y", "yg$", opts) -- Yankee cursor to end of line
vim.keymap.set("n", "n", "nzzzv", opts) -- Next and centralize
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts) -- Move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts) -- Move selection up

-- Disable Keys
vim.keymap.set("i", "<Down>", "<nop>", opts)
vim.keymap.set("i", "<Left>", "<nop>", opts)
vim.keymap.set("i", "<Right>", "<nop>", opts)
vim.keymap.set("i", "<Up>", "<nop>", opts)
vim.keymap.set("n", "<Down>", "<nop>", opts)
vim.keymap.set("n", "<Left>", "<nop>", opts)
vim.keymap.set("n", "<Right>", "<nop>", opts)
vim.keymap.set("n", "<Up>", "<nop>", opts)
vim.keymap.set("n", "Q", "<nop>", opts)

-- Terminal
vim.keymap.set("n", "<C-\\>", "<cmd>terminal<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", opts)

-- Telescope
vim.keymap.set("n", "<leader><F1>", "<cmd>Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
