local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "stylelint" }, -- убран пробел
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    vue = { "eslint_d" },
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

-- Автоформатирование при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.js", "*.ts", "*.vue", "*.css" },
  callback = function()
    require("conform").format({ async = false, lsp_fallback = true })
  end,
})

return options
