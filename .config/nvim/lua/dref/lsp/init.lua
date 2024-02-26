local M = {}
require('mason').setup()
require('mason-lspconfig').setup()

local autocmd = require('dref.lsp.autocmd')
local filetype_table
local attachfiletypeopt = function(opts)
	filetype_table = setmetatable({}, {
		__index = function()
			return function()
			end
		end,
	})

	-- assign the provided callbacks to the respective file types in the filetype_attach table
	for filetype, callback in pairs(opts) do
		filetype_table[filetype] = function()
			callback()
		end
	end
end

attachfiletypeopt({
	go = function()
		autocmd.format_on_save()
		autocmd.org_imports()
		autocmd.remove_space()
	end,
	lua = function()
		autocmd.format_on_save()
		autocmd.remove_space()
	end,
	rust = function()
		autocmd.format_on_save()
	end,

})

local on_attach = function(client, bufnr)
	-- set autocommands conditional on server_capabilities
	if client.server_capabilities.documenthighlightprovider then
		autocmd.document_highlight()
		autocmd.document_highlight_clear()
	end

	local nmap = require("dref.utils.keymap").nmap
	local vmap = require("dref.utils.keymap").vmap
	local imap = require("dref.utils.keymap").imap


	nmap('gd', vim.lsp.buf.declaration, "[g]oto [d]eclaration")
	nmap('gd', vim.lsp.buf.definition, "")
	nmap('gi', vim.lsp.buf.implementation, "")
	nmap('gr', vim.lsp.buf.references, "")
	nmap('<c-h>', vim.lsp.buf.signature_help, "")
	imap('<c-h>', vim.lsp.buf.signature_help, "")
	vmap('<c-h>', vim.lsp.buf.signature_help, "")
	nmap('<leader>h', vim.lsp.buf.hover, "")
	nmap('<leader>d', vim.lsp.buf.type_definition, "")
	nmap('<leader>rn', vim.lsp.buf.rename, "")
	nmap('<leader>ca', vim.lsp.buf.code_action, "")

	-- enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	-- attach any filetype specific options to the client
	filetype_table[filetype]()
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

M.servers = function(servers)
	-- ensure the servers above are installed
	local mason_lspconfig = require('mason-lspconfig')

	mason_lspconfig.setup {
		ensure_installed = vim.tbl_keys(servers),
	}

	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
				filetypes = (servers[server_name] or {}).filetypes,
			}
		end,
	}
end

-- setup neovim lua configuration
require('neodev').setup()

return M
