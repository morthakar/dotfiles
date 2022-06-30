local sumneko_root_path = "/usr/lib/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local function create_autocmd()
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = DrefGroup,
        pattern = "*.lua",
        callback = function()
            vim.lsp.buf.formatting_sync()
        end
    })
end

local sumneko_lua = {}
sumneko_lua.init = function(on_attach, capabilities)
    return {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                },
            },
        },
        on_attach = function()
            on_attach()
            create_autocmd()
        end,
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
    }
end
return sumneko_lua
