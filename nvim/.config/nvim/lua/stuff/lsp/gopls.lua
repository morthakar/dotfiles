local M = {}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local keymaps = require(DIRNAME .. ".lsp.keymaps")
local highlight = require(DIRNAME .. ".lsp.highlight")

function ORG_IMPORTS(wait_ms)
     local params = vim.lsp.util.make_range_params()
     params.context = {only = {"source.organizeImports"}}
     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
     for _, res in pairs(result or {}) do
       for _, r in pairs(res.result or {}) do
         if r.edit then
           vim.lsp.util.apply_workspace_edit(r.edit)
         else
           vim.lsp.buf.execute_command(r.command)
         end
       end
     end
end

local on_attach = function()
      vim.api.nvim_exec(
  			[[
        augroup GO_LSP 
          autocmd!
  	      autocmd BufWritePre *.go :silent! lua ORG_IMPORTS(3000)     
        augroup END
      ]],
        false
      )
    keymaps.set()
    highlight.set()
  end

M.setup = function()
  lspconfig.gopls.setup{
      on_attach = on_attach,
    }

end
return M
