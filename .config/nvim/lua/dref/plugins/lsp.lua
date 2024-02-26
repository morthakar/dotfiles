return {
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ 'williamboman/mason.nvim', config = true },
		'williamboman/mason-lspconfig.nvim',

		{ 'j-hui/fidget.nvim',       opts = {} },

		'folke/neodev.nvim',

	},
	config = function()
		local servers = {

			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		}

		require('mason').setup()
		require('mason-lspconfig').setup()

		local autocmd = require('dref.lsp.autocmd')

		local set_filetypeopt = function(opts)
			local table = setmetatable({}, {
				__index = function()
					return function()
					end
				end,
			})

			-- assign the provided callbacks to the respective file types in the filetype_attach table
			for filetype, callback in pairs(opts) do
				table[filetype] = function()
					callback()
				end
			end

			return table
		end

		local filetype_attach = set_filetypeopt({
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

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- ensure the servers above are installed
		local mason_lspconfig = require('mason-lspconfig')

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = function(_, bufnr)
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
						filetype_attach[filetype]()
					end,

					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}

		-- setup neovim lua configuration
		require('neodev').setup()

		-- setup cmp
		require("cmp").setup()
	end

}
