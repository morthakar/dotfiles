require("dref.set")
require("dref.plugins")
require("dref.cmp")
require("dref.lualine")
require("dref.autopairs")

local augroup = vim.api.nvim_create_augroup
DrefGroup = augroup('Dref', {})
local yank_group = augroup('HighlightYank', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = DrefGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

local nmap = require("dref.keymap").nmap
local nnoremap = require("dref.keymap").nnoremap
local vnoremap = require("dref.keymap").vnoremap
local xnoremap = require("dref.keymap").xnoremap
local inoremap = require("dref.keymap").inoremap

nnoremap("<C-e>", ":Ex<CR>")

vnoremap("K", ":m '<-2<CR>gv=gv") -- Move selection up
vnoremap("J", ":m '>+1<CR>gv=gv") -- Move selection down

-- Move files
nnoremap("<C-Left>", ":bprev<CR>")
nnoremap("<C-Right>", ":bnext<CR>")

-- Opens line below or above the current line
inoremap("<S-CR>", "<C-o>o")
inoremap("<C-CR>", "<C-o>O")

-- Selection
nnoremap("Y", "yg$") -- Yankee cursor to end of line
nnoremap("n", "nzzzv") -- Next and centralize
nnoremap("N", "Nzzzv") -- Back search and centralize
nnoremap("J", "mzJ`z") -- Move line up

nnoremap("<C-d>", "<C-d>zz") -- Scroll down
nnoremap("<C-u>", "<C-u>zz") -- Scroll up

-- Remap some keys
inoremap("<C-c>", "<Esc>")
nnoremap("Q", "<nop>")

nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- Current file write perm

nnoremap("<C-s>", ":w<CR>") -- Save

-- Run go
nnoremap("<F5>", ":!go run $(fd main.go)<CR>")

-- Telescope
nnoremap("<leader>f", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>g", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>b", "<cmd>Telescope buffers<CR>")
nnoremap("<leader><F1>", "<cmd>Telescope help_tags<CR>")
