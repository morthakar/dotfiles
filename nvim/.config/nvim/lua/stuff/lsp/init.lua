DIRNAME = "stuff"
local gopls = require(DIRNAME .. ".lsp.gopls")
local sumneko_lua = require(DIRNAME .. ".lsp.sumneko_lua")

local servers = { gopls, sumneko_lua }
for _, lsp in pairs(servers) do
  lsp.setup()
end
