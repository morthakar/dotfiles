vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Lazy init
require("dref.lazy_init")
-- Set Options
require("dref.options")
--require("dref.lsp")

-- Setting Theme
vim.cmd.colorscheme("onedark")

local imap = require("dref.utils.keymap").imap
local nmap = require("dref.utils.keymap").nmap
local vmap = require("dref.utils.keymap").vmap

-- Keymaps
imap("<C-c>", "<Esc>", "")
nmap("<C-Left>", "<cmd>bprev<CR>", "")
nmap("<C-Right>", "<cmd>bnext<CR>", "")
nmap("<C-s>", "<cmd>w<CR>", "")   -- Save
nmap("N", "Nzzzv", "")            -- Back search and centralize
nmap("Y", "yg$", "")              -- Yankee cursor to end of line
nmap("n", "nzzzv", "")            -- Next and centralize

nmap("J", ":m .+1<CR>==", "")     -- Move selection down
nmap("K", ":m .-2<CR>==", "")     -- Move selection up
vmap("J", ":m '>+1<CR>gv=gv", "") -- Move selection down
vmap("K", ":m '<-2<CR>gv=gv", "") -- Move selection up

-- Disable Keys
imap("<Down>", "<nop>", "")
imap("<Left>", "<nop>", "")
imap("<Right>", "<nop>", "")
imap("<Up>", "<nop>", "")
nmap("<Down>", "<nop>", "")
nmap("<Left>", "<nop>", "")
nmap("<Right>", "<nop>", "")
nmap("<Up>", "<nop>", "")
nmap("Q", "<nop>", "")

-- Diagnostic keymaps
nmap('[', vim.diagnostic.goto_prev)
nmap(']', vim.diagnostic.goto_next)
nmap('<leader>e', vim.diagnostic.open_float)
nmap('<leader>q', vim.diagnostic.setloclist)
