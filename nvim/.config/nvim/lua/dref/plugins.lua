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
return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    -- Defaults
    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    use("windwp/nvim-autopairs")
    use("nvim-lualine/lualine.nvim")
    use("norcalli/nvim-colorizer.lua")

    -- Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("simrat39/symbols-outline.nvim")
    use("jose-elias-alvarez/null-ls.nvim")

    -- Completion
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("saadparwaiz1/cmp_luasnip")

    -- Snippets
    use("L3MON4D3/LuaSnip")

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("Mofiqul/dracula.nvim")
    use("folke/tokyonight.nvim")

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    -- Debug
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

end)
