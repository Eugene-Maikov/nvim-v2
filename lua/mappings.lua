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
map('n', '<leader>c', '<cmd>NvimTreeCollapse<CR>', { desc = "NvimTree Сворачивает текущую папку" })
map('n', '<leader>C', '<cmd>NvimTreeCollapseKeepBuffers<CR>', { desc = "NvimTree Сворачивает все, кроме корня" })

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

local opts = { noremap = true, silent = true, desc = "Tab Navigation" }
-- 📌 Управление вкладками (табами)
map("n", "<leader>tn", ":tabnew<CR>", { desc = "Создать новую вкладку" }) -- Новая вкладка
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Закрыть текущую вкладку" }) -- Закрыть вкладку
map("n", "<leader>to", ":tabonly<CR>", { desc = "Закрыть все, кроме текущей вкладки" }) -- Закрыть остальные

-- 🔢 Переключение по номеру
map("n", "<leader>1", "1gt", opts) -- Перейти к вкладке 1
map("n", "<leader>2", "2gt", opts) -- Перейти к вкладке 2
map("n", "<leader>3", "3gt", opts) -- Перейти к вкладке 3
map("n", "<leader>4", "4gt", opts) -- Перейти к вкладке 4
map("n", "<leader>5", "5gt", opts) -- Перейти к вкладке 5

-- Перемещение строк
vim.keymap.set('n', '<leader><Down>', ':m .+1<CR>==', { desc = 'Перемещение строк Вниз' })
vim.keymap.set('n', '<leader><Up>', ':m .-2<CR>==', { desc = 'Перемещение строк Вверх' })
vim.keymap.set('v', '<leader><Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<leader><Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")o
