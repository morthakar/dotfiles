local theme = "gruvbox"

if theme == "onedark" then
	local ok, onedark = pcall(require, "onedark")
	if not ok then
		return
	end

	onedark.setup { style = 'warmer' } -- Options: dark, darker, cool, deep, warm, warmer, light
	onedark.load()
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
