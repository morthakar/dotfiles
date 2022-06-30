local gopls = {}

local function org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

local function create_autocmd()
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = DrefGroup,
        pattern = "*.go",
        callback = function()
            org_imports(3000)
            vim.lsp.buf.formatting_sync()
        end
    })
end

gopls.init = function(on_attach, capabilities)
    return {
        cmd = { "gopls" },
        settings = {
            gopls = {
                codelenses = { test = true },
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
            flags = {
                debounce_text_changes = 200,
            },
        },
        on_attach = function()
            on_attach()
            create_autocmd()
        end,
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
    }
end
return gopls
