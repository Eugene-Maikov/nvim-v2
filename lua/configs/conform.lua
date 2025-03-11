local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "stylelint " },
    html = { "eslint_d" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    vue = { "eslint_d" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
