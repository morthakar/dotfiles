return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- "rose-pine/neovim",
--"navarasu/onedark.nvim",
--"folke/tokyonight.nvim",
