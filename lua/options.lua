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

vim.api.nvim_create_user_command('Dev', function()
  -- Запускаем npm run dev в терминале
  vim.cmd('split | term npm run dev')
  -- Ожидаем несколько секунд, чтобы сервер успел запуститься
  vim.defer_fn(function()
    -- Открыть браузер (для macOS), можно поменять на свою команду, например для Linux
    vim.fn.jobstart("open http://localhost:3000", { detach = true })
    -- Закрыть терминал после открытия браузера
    vim.cmd('q')
  end, 3000)  -- Задержка в миллисекундах, подстрой под себя
end, {})