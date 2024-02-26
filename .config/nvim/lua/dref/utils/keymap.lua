local M = {}

M.nmap = function(keys, func, desc, bufnr)
	vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

M.imap = function(keys, func, desc, bufnr)
	vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
end

M.vmap = function(keys, func, desc, bufnr)
	vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
end

return M
