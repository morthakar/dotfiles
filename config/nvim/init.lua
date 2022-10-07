-- Globals
vim.g.mapleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local augroup = vim.api.nvim_create_augroup
DrefGroup = augroup('Dref', {})
local yank_group = augroup('HighlightYank', {})

local autocmd = vim.api.nvim_create_autocmd

-- Faster yank highlight
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

-- Remove blank space on save for all files
autocmd({ "BufWritePre" }, {
	group = DrefGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

require("dref")
require("dref.lsp")
require("dref.plugins.autopairs")
require("dref.plugins.bufferline")
require("dref.plugins.cmp")
require("dref.plugins.colors")
require("dref.plugins.lualine")
require("dref.plugins.packer")
require("dref.plugins.treesitter")
