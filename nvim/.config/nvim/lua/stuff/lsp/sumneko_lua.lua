local M = {}

local sumneko_root_path = "/opt/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local lspconfig = require 'lspconfig'
local keymaps = require(DIRNAME .. ".lsp.keymaps")
local highlight = require(DIRNAME .. ".lsp.highlight")

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function()
	keymaps.set()
	highlight.set()
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.setup = function ()
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
end
return M
