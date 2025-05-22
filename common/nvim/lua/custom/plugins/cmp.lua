return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Adds other completion capabilities.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- See `:help cmp`
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
          -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
      },
      completion = { completeopt = "menu,menuone" },
      mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete {},

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Luasnip
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm {
                select = true,
              }
            end
          else
            fallback()
          end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      },
    }
  end,
}
