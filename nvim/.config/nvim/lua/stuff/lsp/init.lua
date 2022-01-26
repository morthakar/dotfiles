local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("stuff.lsp.lsp-installer")
require("stuff.lsp.handlers").setup()
--require "stuff.lsp.null-ls"
