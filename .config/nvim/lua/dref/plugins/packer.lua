-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	vim.cmd [[packadd packer.nvim]]
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerCompile',
	group = packer_group,
	pattern = "packer.lua",
})

-- Have packer use a popup window
require("packer").init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

require("packer").startup(function()
	use "wbthomason/packer.nvim"

	-- Treesitter
	use { -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		run = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	}

	use { -- Additional text objects via treesitter
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
	}

	-- Debug
	use "mfussenegger/nvim-dap"
	use "rcarriga/nvim-dap-ui"
	use "theHamsta/nvim-dap-virtual-text"

	-- Telescope
	use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

	-- LSP
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
	use("nvim-lua/lsp_extensions.nvim")
	use("simrat39/symbols-outline.nvim")
	use('simrat39/rust-tools.nvim')
	use('jose-elias-alvarez/null-ls.nvim')
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}

	-- Completion
	use { -- Autocompletion
		'hrsh7th/nvim-cmp',
		requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
	}

	-- Git related plugins
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'lewis6991/gitsigns.nvim'

	-- IDE
	use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
	use { 'numToStr/Comment.nvim' }
	use("kylechui/nvim-surround")
	use("nvim-lualine/lualine.nvim")
	use("windwp/nvim-autopairs")

	-- Colorscheme section
	use("gruvbox-community/gruvbox")
	use("Mofiqul/dracula.nvim")
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("navarasu/onedark.nvim")

	if is_bootstrap then
		require('packer').sync()
	end
end)
