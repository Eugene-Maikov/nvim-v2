require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Trouble
map("n", "<leader>qq", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "Диагностика (Trouble)" })
map("n", "<leader>qQ", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Диагностика текущего файла (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Список символов (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Определения / ссылки LSP (Trouble)" })
map("n", "<leader>qL", "<cmd>Trouble loclist toggle<cr>", { desc = "Локальный список (Trouble)" })
map("n", "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Список исправлений (Trouble)" })

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git лог" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "История файла Git" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Последний коммит Git" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "История файла Git" })

-- Terminal
map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, { desc = "Переключить терминал (вертикально)" })
map("n", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, { desc = "Переключить терминал (горизонтально)" })
map("n", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Переключить терминал (плавающий)" })
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end, { desc = "Переключить терминал (вертикально)" })
map("t", "<C-\\>", function()
  require("nvchad.term").toggle { pos = "sp" }
end, { desc = "Переключить терминал (горизонтально)" })
map("t", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Переключить терминал (плавающий)" })

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
