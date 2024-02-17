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


