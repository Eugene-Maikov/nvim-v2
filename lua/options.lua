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

-- Подключение модуля с сервером разработки
local dev_server = require('configs/utils/dev_server')

-- Команда для запуска сервера
vim.api.nvim_create_user_command('Dev', function()
  local next_port = dev_server.get_next_available_port(3000)
  dev_server.run_dev(true, next_port)
end, {})

-- Команда для завершения всех процессов node
vim.api.nvim_create_user_command('DK', function()
  vim.fn.jobstart("killall node", { detach = true })
  vim.notify("Все localhost процессы закрыты", vim.log.levels.INFO)
end, {})

-- Команда для завершения процесса на конкретном порту
vim.api.nvim_create_user_command('DKP', function(opts)
  local port = opts.args
  if port and tonumber(port) then
    dev_server.kill_port(port)
  else
    vim.notify("Неверный номер порта", vim.log.levels.ERROR)
  end
end, { nargs = 1 })

-- Команда для получения списка занятых портов
vim.api.nvim_create_user_command('DL', function()
  dev_server.list_ports()
end, {})
