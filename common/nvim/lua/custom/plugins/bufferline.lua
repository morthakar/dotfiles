return {
	"akinsho/bufferline.nvim",
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
			},
		})
	end,
}
