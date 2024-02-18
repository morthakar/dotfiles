local M = {}
local set_key = require('dref.utils.keymap')
local autocmd = require('dref.lsp.autocmd')
local lspconfig = require('lspconfig')

function M.get_autocmd()
	return autocmd
end

local filetype_attach
function M.attachFiletypeOpt(opts)
	filetype_attach = setmetatable({}, {
		__index = function()
			return function()
			end
		end,
	})

	-- Assign the provided callbacks to the respective file types in the filetype_attach table
	for filetype, callback in pairs(opts) do
		filetype_attach[filetype] = function()
			callback()
		end
	end
end

local on_attach = function(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		autocmd.document_highlight()
		autocmd.document_highlight_clear()
	end

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	set_key.nmap({ 'gD', vim.lsp.buf.declaration, bufopts })
	set_key.nmap({ 'gd', vim.lsp.buf.definition, bufopts })
	set_key.nmap({ 'gi', vim.lsp.buf.implementation, bufopts })
	set_key.nmap({ 'gr', vim.lsp.buf.references, bufopts })
	set_key.nmap({ '<C-h>', vim.lsp.buf.signature_help, bufopts })
	set_key.imap({ '<C-h>', vim.lsp.buf.signature_help, bufopts })
	set_key.vmap({ '<C-h>', vim.lsp.buf.signature_help, bufopts })
	set_key.nmap({ '<leader>h', vim.lsp.buf.hover, bufopts })
	set_key.nmap({ '<leader>D', vim.lsp.buf.type_definition, bufopts })
	set_key.nmap({ '<leader>rn', vim.lsp.buf.rename, bufopts })
	set_key.nmap({ '<leader>ca', vim.lsp.buf.code_action, bufopts })

	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	-- Attach any filetype specific options to the client
	filetype_attach[filetype]()
end


-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.on_attach = on_attach

M.setup = function(servers)
	for server, opts in pairs(servers) do
		lspconfig[server].setup {
			opts,
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end
end


-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

return M
