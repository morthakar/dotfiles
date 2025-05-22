return {
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = true,
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
  },
}
