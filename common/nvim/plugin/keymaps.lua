-- NOTE: Diagnostic keymaps
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  vim.snippet.jump(-1)
end, { buffer = true })

-- NOTE: Keys remap
vim.keymap.set("n", "K", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("n", "J", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-Left>", "<cmd>bprev<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-q>", "<cmd>bdelete<CR>", { silent = true, desc = "Close buffer" })

-- NOTE: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<NOP>")
vim.keymap.set("n", "<right>", "<NOP>")
vim.keymap.set("n", "<up>", "<NOP>")
vim.keymap.set("n", "<down>", "<NOP>")

-- Set NvimTree Toggle
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTreeToggle" })

--  NOTE: Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
vim.keymap.set("n", "<Esc>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
