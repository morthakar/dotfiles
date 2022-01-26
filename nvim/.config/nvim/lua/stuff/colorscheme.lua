vim.cmd [[
try
  " let g:gruvbox_contrast_dark = 'hard'
  " let g:gruvbox_invert_selection='0'
  colorscheme gruvbox
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
