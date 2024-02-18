local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"numToStr/Comment.nvim",
	"akinsho/bufferline.nvim",
	"williamboman/mason.nvim",
	"L3MON4D3/LuaSnip",
	"EdenEast/nightfox.nvim",
	"navarasu/onedark.nvim",
	"folke/tokyonight.nvim",
	{ "neovim/nvim-lspconfig",         dependencies = { "nvim-lua/lsp_extensions.nvim" }, },
	{ "nvim-lualine/lualine.nvim",     dependencies = { "kyazdani42/nvim-web-devicons" } },
	{ "hrsh7th/nvim-cmp",              dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "saadparwaiz1/cmp_luasnip" } },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-telescope/telescope-fzf-native.nvim", "nvim-lua/plenary.nvim" } },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "go", "zig", "rust", "javascript", "html", "bash" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	}
})
