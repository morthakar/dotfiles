return {
	-- Themes
	"navarasu/onedark.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require('onedark').setup {
			style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
		}
		require('onedark').load()
	end,

	-- Status line
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				icons_enabled = true,
				theme = "gruvbox",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icons_enabled = true,
						icon = "",
					},
					{
						"diff",
						colored = true,
						symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
						--cond = hide_in_width
					}
				},
				lualine_c = { { "filename", path = 3, } },

				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn" },
						symbols = { error = " ", warn = " " },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
					"filetype"
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		},
	},
}
