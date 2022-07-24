local theme = "onedark"

if theme == "onedark" then
	-- Options: dark, darker, cool, deep, warm, warmer, light
	require('onedark').setup {
		style = 'warmer'
	}
	require('onedark').load()
end

if theme == "gruvbox" then
	--vim.g.gruvbox_contrast_dark = 'hard'
	vim.opt.background = "dark"
	vim.g.gruvbox_invert_selection = '0'
	vim.cmd("colorscheme " .. theme)
end

if theme == "tokyonight" then
	vim.g.tokyonight_style = "night"
	vim.cmd("colorscheme " .. theme)
end
