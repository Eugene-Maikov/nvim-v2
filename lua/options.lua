require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


-- пользовательские знаки (icons) для диагностики ошибок
local signs = {
  Error = "✖",  -- Альтернатива: "⛔", "❌", "🚫"
  Warn  = "⚠",  -- Альтернатива: "❗", "🔶", "🟠"
  Hint  = "💡",  -- Альтернатива: "🔍", "✨", "🛈"
  Info  = "ℹ",  -- Альтернатива: "📘", "🛈", "🔵"
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Настройка для файлов .vue
vim.cmd([[ autocmd FileType vue setlocal commentstring=<!--\ %s\ --> ]])

-- Номена строк
vim.wo.number = true
vim.wo.relativenumber = true

-- Мышь
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Буфер обмена
vim.opt.clipboard = "unnamedplus"

-- Перенос строк в длинной строке
vim.opt.wrap = true 

-- Отступы
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Другое
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- suppress ~ at EndOfBuffer
	-- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▼",
	foldsep = "│",
	foldclose = "❯"
}

vim.o.hlsearch = true  -- Подсвечивать результаты поиска

local function run_dev(open_browser)
  -- Запуск npm run dev в скрытом терминале
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_term(term_buf, {})
  vim.fn.jobstart("npm run dev", { detach = true })

  -- Открытие браузера (если нужно) и удаление буфера
  vim.defer_fn(function()
    if open_browser then vim.fn.jobstart("open http://localhost:3000", { detach = true }) end
    vim.api.nvim_buf_delete(term_buf, { force = true })
  end, 3000)
end

vim.api.nvim_create_user_command('Dev', function() run_dev(false) end, {})
vim.api.nvim_create_user_command('Devo', function() run_dev(true) end, {})

