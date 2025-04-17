local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "stylelint" },
    scss = { "stylelint" },
    javascript = { "eslint_d", "prettier" },
    typescript = { "eslint_d", "prettier" },
    vue = { "eslint_d", "prettier" },
    html = { "prettier" },  -- Используем Prettier для HTML
  },

  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

-- Автоформатирование при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.js", "*.ts", "*.vue", "*.css", "*.scss", "*.html" },  -- Добавляем HTML
  callback = function()
    require("conform").format({ async = false, lsp_fallback = true })
  end,
})

return options
