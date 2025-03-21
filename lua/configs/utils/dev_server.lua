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
    vim.notify("Локальный сервер запущен на http://localhost:" .. port, vim.log.levels.INFO)
    if open_browser then
      vim.fn.jobstart("open http://localhost:" .. port, { detach = true })
    end
    vim.api.nvim_buf_delete(term_buf, { force = true })
  end, 3000)
end

-- Завершение процесса на указанном порту
local function kill_port(port)
  local handle = io.popen("lsof -ti tcp:" .. port)
  local result = handle:read("*a")
  handle:close()

  if result ~= "" then
    vim.fn.jobstart("lsof -ti tcp:" .. port .. " | xargs kill", { detach = true })
    vim.notify("Процесс на порту " .. port .. " закрыт", vim.log.levels.INFO)
  else
    vim.notify("Порт " .. port .. " не занят", vim.log.levels.INFO)
  end
end

-- Получение списка занятых портов 3000
local function list_ports()
  local handle = io.popen("lsof -i -P -n | grep LISTEN | grep ':300' | awk -F: '{print $2}' | awk '{print $1}'")
  local result = handle:read("*a")
  handle:close()

  if result ~= "" then
    vim.notify("Занятые порты: " .. result, vim.log.levels.INFO)
  else
    vim.notify("Нет занятых портов", vim.log.levels.INFO)
  end
end

-- Возвращаем функции
return {
  run_dev = run_dev,
  kill_port = kill_port,
  list_ports = list_ports,
  get_next_available_port = get_next_available_port
}