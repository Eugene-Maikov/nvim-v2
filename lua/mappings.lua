require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Trouble
map("n", "<leader>td", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "Диагностика (Trouble)" })
map("n", "<leader>tD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Диагностика текущего файла (Trouble)" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Список символов (Trouble)" })

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git лог" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "История файла Git" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Последний коммит Git" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "История файла Git" })

-- Terminal
local function map_term(key, pos, desc)
  map("n", key, function()
    require("nvchad.term").toggle({ pos = pos })
  end, { desc = desc })
  map("t", key, function()
    require("nvchad.term").toggle({ pos = pos })
  end, { desc = desc })
end

-- Теперь используй map_term для всех маппингов терминала:
map_term("<C-]>", "vsp", "Переключить терминал (вертикально)")
map_term("<C-\\>", "sp", "Переключить терминал (горизонтально)")
map_term("<C-f>", "float", "Переключить терминал (плавающий)")

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree Меню навигации toggle" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree Меню навигации toggle" })

-- Маппинги для открытия/закрытия всех свёрток
map('n', 'zR', require('ufo').openAllFolds, { desc = 'Открыть все свёртки' })
map('n', 'zM', require('ufo').closeAllFolds, { desc = 'Закрыть все свёртки' })

-- Маппинги для сплитов
map('n', '|', ':vsplit<CR>', {desc = "сплит Вертикальный"})
map('n', '\\', ':split<CR>', {desc = "сплит Горизонтальный"})

-- Basic
map('i', 'jj', '<Esc>', { desc = "Выход из режима вставки" })
map('n', '<leader>q', ':q<CR>', { desc = "Закрыть текущий файл" })
map("n", ";", ":", { desc = "Перейти в командный режим" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Сохранить" })
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Закрыть все буферы" })
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
