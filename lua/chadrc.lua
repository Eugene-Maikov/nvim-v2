-- этот файл должен иметь ту же структуру, что и nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Пожалуйста, прочтите этот файл, чтобы узнать обо всех доступных вариантах:(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",
	transparency = true,
  statusline = {
    theme = "vscode_colored",
  },

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
		DiffChange = {
      bg = "#464414",
      fg = "none",
    },
    DiffAdd = {
      bg = "#103507",
      fg = "none",
    },
    DiffRemoved = {
      bg = "#461414",
      fg = "none",
    },
	},
}

M.nvdash = { 
	load_on_startup = true,
	header = {
		"██████╗░░██╗ ██████╗░░░█████╗░",
		"██╔══██╗ ██║ ██╔══██╗ ██╔══██╗",
		"██████╦╝ ██║ ██████╦╝ ███████║",
		"██╔══██╗ ██║ ██╔══██╗ ██╔══██║",
		"██████╦╝ ██║ ██████╦╝ ██║░░██║",
		"╚═════╝░░╚═╝ ╚═════╝░ ╚═╝░░╚═╝",
		"                           ",
		"                           ",
	},
	buttons = {
		{ txt = "  Найти файл", keys = "ff", cmd = "Telescope find_files" },
		{ txt = "  Недавние файлы", keys = "fo", cmd = "Telescope oldfiles" },
		{ txt = "󰈭  Найти слово", keys = "fw", cmd = "Telescope live_grep" },
		{ txt = "󱥚  Темы", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
		{ txt = "  Сочетания клавиш", keys = "ch", cmd = "NvCheatsheet" },
	
		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	
		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " мс"
				return "  Загружено " .. stats.loaded .. "/" .. stats.count .. " плагинов за " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
		},
	}
}
-- M.ui = {
--       tabufline = {
--           q
--      }
-- }

return M
