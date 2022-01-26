local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- A plugin/package management for Neovim.
  use "windwp/nvim-autopairs" -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use "numToStr/Comment.nvim" -- Smart and Powerful commenting plugin for neovim.
  use "ahmedkhalf/project.nvim" -- The superior project management solution for neovim.
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.
  use "lukas-reineke/indent-blankline.nvim" -- Adds indentation guides to all lines (including empty lines).
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight.

  -- Ui
  use "nvim-lualine/lualine.nvim" -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  use "kyazdani42/nvim-web-devicons" -- A lua `fork` of vim-web-devicons for neovim.
  use "kyazdani42/nvim-tree.lua" -- A file explorer tree for neovim written in lua.
  use "akinsho/bufferline.nvim" -- A snazzy buffer line (with minimal tab integration) for Neovim built using lua.
  use "akinsho/toggleterm.nvim" -- persist and toggle multiple terminals during an editing session

  -- Colorschemes
  use "gruvbox-community/gruvbox"
  use {'dracula/vim', as = 'dracula'}

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- A completion plugin for neovim coded in Lua.
  use "hrsh7th/cmp-buffer" -- nvim-cmp source for buffer words.
  use "hrsh7th/cmp-path" -- nvim-cmp source for path
  use "hrsh7th/cmp-cmdline" -- nvim-cmp source for vim's cmdline
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim builtin LSP client

  -- snippets
  use "L3MON4D3/LuaSnip" -- Snippet Engine for Neovim written in Lua.
  use "rafamadriz/friendly-snippets" -- Set of preconfigured snippets for different languages.

  -- LSP
  use "neovim/nvim-lspconfig" -- Quickstart configurations for the Nvim LSP client.
  use "williamboman/nvim-lsp-installer" -- Manage LSP servers locally with :LspInstall. With full Windows support!
  use "tamago324/nlsp-settings.nvim" -- A plugin for setting Neovim LSP with JSON files.
  use "jose-elias-alvarez/null-ls.nvim" -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.

  -- Telescope
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions.
  use "nvim-telescope/telescope.nvim" -- Find, Filter, Preview, Pick. All lua, all the time.
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- Nvim Treesitter configurations and abstraction layer
  use "JoosepAlviste/nvim-ts-context-commentstring" -- Plugin for setting the commentstring based on the cursor location in a file.

  -- Git
  use "lewis6991/gitsigns.nvim" -- Git integration for buffers.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
