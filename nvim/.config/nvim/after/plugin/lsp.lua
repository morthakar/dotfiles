local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local keymap = require("dref.lsp.keymap").set()

require("dref.lsp.servers").run({
    servers = { "gopls", "sumneko_lua" },
    --keymap = keymap,
    capabilities = capabilities,
})
