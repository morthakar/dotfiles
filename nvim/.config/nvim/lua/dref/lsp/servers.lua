local servers = {}

servers.run = function(_config)
    for _, server in pairs(_config.servers) do
        local ok, result = pcall(require, "dref.lsp." .. server)
        if ok then
            local config = result.init(--[[_config.keymap,--]] _config.capabilities)
            require("lspconfig")[server].setup(config)
        else
            vim.schedule(function()
                vim.api.nvim_notify("Error running server: " .. server .. " " .. result, vim.log.levels.ERROR, {})
            end)
            return
        end
    end
end

return servers
