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

--=============================================================================
-- Проверка, свободен ли порт
local function is_port_free(port)
  local handle = io.popen("lsof -i:" .. port)
  local result = handle:read("*a")
  handle:close()
  return result == ""
end

-- Получение следующего доступного порта начиная с заданного
local function get_next_available_port(start_port)
  local port = start_port
  while not is_port_free(port) do
    port = port + 1
  end
  return port
end

-- Запуск локального сервера на указанном порту
local function run_dev(open_browser, custom_port)
  local port = custom_port or 3000

  -- Запуск npm run dev на найденном порту
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_term(term_buf, {})
  vim.fn.jobstart("npm run dev -- --port=" .. port, { detach = true })

  -- Уведомление до открытия браузера
  vim.defer_fn(function()
    -- Информирование о запуске локального сервера
    vim.notify("Локальный сервер запущен на http://localhost:" .. port, vim.log.levels.INFO)

    -- Открытие браузера (если нужно)
    if open_browser then
      vim.fn.jobstart("open http://localhost:" .. port, { detach = true })
    end
    
    vim.api.nvim_buf_delete(term_buf, { force = true })
  end, 3000)
end

-- Запуск сервера на доступном порту начиная с 3000
vim.api.nvim_create_user_command('Dev', function()
  local next_port = get_next_available_port(3000)
  run_dev(true, next_port)
end, {})

--=============================================================================
-- Завершение процесса на указанном порту
local function kill_port(port)
  local handle = io.popen("lsof -ti tcp:" .. port)
  local result = handle:read("*a")
  handle:close()

  -- Если процесс найден, завершаем его
  if result ~= "" then
    vim.fn.jobstart("lsof -ti tcp:" .. port .. " | xargs kill", { detach = true })
    vim.notify("Процесс на порту " .. port .. " закрыт", vim.log.levels.INFO)
  else
    -- Если порт не занят
    vim.notify("Порт " .. port .. " не занят", vim.log.levels.INFO)
  end
end

-- Команда для завершения всех процессов node
vim.api.nvim_create_user_command('DK', function()
  vim.fn.jobstart("killall node", { detach = true })
  vim.notify("Все localhost процессы закрыты", vim.log.levels.INFO)
end, {})

-- Команда для завершения процесса на конкретном порту
vim.api.nvim_create_user_command('DKP', function(opts)
  local port = opts.args
  if port and tonumber(port) then
    kill_port(port)
  else
    vim.notify("Неверный номер порта", vim.log.levels.ERROR)
  end
end, { nargs = 1 })

--=============================================================================
-- Получение списка занятых портов 3000
vim.api.nvim_create_user_command('DL', function()
  -- Используем lsof для поиска процессов на портах 3000
  local handle = io.popen("lsof -i -P -n | grep LISTEN | grep ':300' | awk -F: '{print $2}' | awk '{print $1}'")
  local result = handle:read("*a")
  handle:close()

  -- Если порты заняты, выводим их
  if result ~= "" then
    vim.notify("Занятые порты: " .. result, vim.log.levels.INFO)
  else
    vim.notify("Нет занятых портов", vim.log.levels.INFO)
  end
end, {})

--=============================================================================
-- Весь функционал сгруппирован в команде и оптимизирован для удобства
-- Только для 3000 портов

-- DevList - список занятых портов
-- DK (DevsKill) - закрыть все порты
-- DKP (DevsKillPort 3000) -- закрыть порт по номеру
-- Dev - запустить и перейти в браузер
