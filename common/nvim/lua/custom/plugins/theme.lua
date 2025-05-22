return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    vim.cmd.colorscheme "catppuccin"

    --   local groups = {
    --     "Normal",
    --     "Comment",
    --     "Constant",
    --     "Special",
    --     "Identifier",
    --     "Statement",
    --     "PreProc",
    --     "Type",
    --     "Underlined",
    --     "Todo",
    --     "String",
    --     "Function",
    --     "Conditional",
    --     "Repeat",
    --     "Operator",
    --     "Structure",
    --     "LineNr",
    --     "NonText",
    --     "SignColumn",
    --     "CursorLineNr",
    --     "EndOfBuffer",
    --     "VertSplit",
    --   }
    --
    --   for name, attrs in pairs(vim.api.nvim_get_hl(0, {})) do
    --     -- if vim.tbl_contains(groups, name) and (attrs.bg or attrs.ctermbg) then
    --     if attrs.bg or attrs.ctermbg then
    --       local new_attr = vim.tbl_extend("force", attrs, {
    --         bg = "NONE",
    --         ctermbg = "NONE",
    --       })
    --       vim.api.nvim_set_hl(0, name, new_attr)
    --     end
    --   end
  end,
}

-- "rose-pine/neovim",
--"navarasu/onedark.nvim",
--"folke/tokyonight.nvim",
