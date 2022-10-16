local has_autocmd, autocmd = pcall(require, "dref.lsp.autocmd")
if not has_autocmd then
	return
end

local filetype_attach = setmetatable({
	go = function()
		autocmd.format()
		autocmd.org_imports()
		autocmd.remove_space()
	end,

	lua = function()
		autocmd.format()
		autocmd.remove_space()
	end,

	rust = function()
		autocmd.format()
	end

}, {
	__index = function()
		return function() end
	end,
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		autocmd.document_highlight()
		autocmd.document_highlight_clear()
	end

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('v', '<C-h>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	-- Attach any filetype specific options to the client
	filetype_attach[filetype]()

end

local has_lsp, lspconfig = pcall(require, 'lspconfig')
if not has_lsp then
	return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local flags = { debounce_text_changes = 200 }

lspconfig.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = flags,
}

local sumneko_root_path = "/usr/lib/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

lspconfig.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
	flags = flags,
})

lspconfig["rust_analyzer"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

local has_symbols, symbols = pcall(require, "symbols-outline")
if not has_symbols then
	return
end

symbols.setup({
	highlight_hovered_item = true,
	show_guides = true,
})
