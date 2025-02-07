return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = event.buf })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = event.buf })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
        vim.keymap.set("n", "g[", vim.diagnostic.goto_next, { buffer = event.buf })
        vim.keymap.set("n", "g]", vim.diagnostic.goto_prev, { buffer = event.buf })

        vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { buffer = event.buf })
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = event.buf })

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = event.buf })
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = event.buf })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      jqls = {},
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {},
        },
      },
      zls = {},
      gopls = {
        {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
      },
      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format lua code
      "bashls",
      "shellcheck",
      "shfmt",
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          require("lspconfig")[server_name].setup {
            cmd = server.cmd,
            settings = server.settings,
            filetypes = server.filetypes,
            capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
          }
        end,
      },
    }
  end,
}
