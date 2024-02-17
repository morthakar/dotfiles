vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("dref.utils.autocmd")
require("dref.plugins")
require("dref.lsp")

local imap = require("dref.utils.keymap").imap
local nmap = require("dref.utils.keymap").nmap
local vmap = require("dref.utils.keymap").vmap

-- Options
vim.o.backup = false
vim.o.completeopt = 'menuone,noselect'
vim.o.cursorline = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 50

-- vim.opt.shortmess:append("c")
-- vim.o.softtabstop = 4
-- vim.o.errorbells = false
-- vim.o.isfname:append("@-@")
-- vim.o.guicursor = "a:"
-- vim.o.scrolloff = 8
-- vim.o.shiftwidth = 4
-- vim.o.tabstop = 4
-- vim.o.wrap = false

-- Keymaps
local opts = { noremap = true }
imap({ "<C-c>", "<Esc>", opts })
nmap({ "<C-Left>", "<cmd>bprev<CR>", opts })
nmap({ "<C-Right>", "<cmd>bnext<CR>", opts })
nmap({ "<C-s>", "<cmd>w<CR>", opts })   -- Save
nmap({ "N", "Nzzzv", opts })            -- Back search and centralize
nmap({ "Y", "yg$", opts })              -- Yankee cursor to end of line
nmap({ "n", "nzzzv", opts })            -- Next and centralize

nmap({ "J", ":m .+1<CR>==", opts })     -- Move selection down
nmap({ "K", ":m .-2<CR>==", opts })     -- Move selection up
vmap({ "J", ":m '>+1<CR>gv=gv", opts }) -- Move selection down
vmap({ "K", ":m '<-2<CR>gv=gv", opts }) -- Move selection up

-- Disable Keys
imap({ "<Down>", "<nop>", opts })
imap({ "<Left>", "<nop>", opts })
imap({ "<Right>", "<nop>", opts })
imap({ "<Up>", "<nop>", opts })
nmap({ "<Down>", "<nop>", opts })
nmap({ "<Left>", "<nop>", opts })
nmap({ "<Right>", "<nop>", opts })
nmap({ "<Up>", "<nop>", opts })
nmap({ "Q", "<nop>", opts })

-- Telescope
nmap({ "<leader>sf", require('telescope.builtin').oldfiles, { desc = '[S]earch [H]elp' }, opts })
nmap({ "<leader>sd", require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' }, opts })
nmap({ "<leader>?", require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' }, opts })
nmap({ "<leader>b", require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' }, opts })
nmap({ "<leader>f", require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' }, opts })
nmap({ "<leader>g", require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' }, opts })

-- Diagnostic keymaps
nmap({ '[', vim.diagnostic.goto_prev })
nmap({ ']', vim.diagnostic.goto_next })
nmap({ '<leader>e', vim.diagnostic.open_float })
nmap({ '<leader>q', vim.diagnostic.setloclist })
