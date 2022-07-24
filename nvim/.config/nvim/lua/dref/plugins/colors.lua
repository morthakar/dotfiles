local theme = "gruvbox"

vim.opt.background = "dark"

if theme == "gruvbox" then
    --vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_invert_selection = '0'
end

vim.cmd("colorscheme " .. theme)
