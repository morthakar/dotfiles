local M = {}
local k = require("dref.keymap")
local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
        end,
    }, _config or {})
end

M.set = function()
    k.nnoremap("<leader>d", function() vim.lsp.buf.definition() end)
    k.nnoremap("<leader>h", function() vim.lsp.buf.hover() end)
    k.nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
    k.nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
    k.nnoremap("[d", function() vim.diagnostic.goto_next() end)
    k.nnoremap("]d", function() vim.diagnostic.goto_prev() end)
    k.nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
    k.nnoremap("<leader>rr", function() vim.lsp.buf.references() end)
    k.nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
    k.inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
end
return M
