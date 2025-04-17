require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  vue = { "eslint_d" },
  css = { "stylelint" },
  scss = { "stylelint" },  -- Добавляем поддержку SCSS
  html = { "eslint_d" },  -- Добавляем HTML
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
