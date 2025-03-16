return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog", dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "eslint-lsp",
        "typescript-language-server",
      },
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "typescript",
          "javascript",
          "html",
          "css",
          "vue",
          "gitcommit",
          "graphql",
          "json",
          "json5",
          "lua",
          "markdown",
          "vim",
          "vimdoc",
        },                             
        sync_install = false,          
        ignore_install = { "haskell" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }
    end,
    dependencies = {
      -- "hiphish/rainbow-delimiters.nvim",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = false,          -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = true   -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        --[[ per_filetype = {
            ["html"] = {
              enable_close = false
            }
          } ]]
      })
    end

  },
  {
    "wurli/contextindent.nvim",
    -- This is the only config option; you can use it to restrict the files
    -- which this plugin will affect (see :help autocommand-pattern).
    opts = { pattern = "*" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
  },
  {
    {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      -- Общие настройки свёртывания
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Настройка провайдера (например, Treesitter + отступы)
      require('ufo').setup({
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end
      })
      end,
    },
  },
  {
    "folke/noice.nvim",
    lazy = false,
        dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      messages = { enabled = false }, -- Отключить сообщения от noice
      lsp = {
        -- переопределить рендеринг markdown, чтобы **cmp** и другие плагины использовали **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false, -- Отключить конвертацию LSP-ответов в markdown
          ["vim.lsp.util.stylize_markdown"] = false, -- Отключить стилизацию markdown в LSP-ответах
          ["cmp.entry.get_documentation"] = true, -- Разрешить cmp использовать noice для отображения документации
        },
        progress = {
          enabled = false, -- Отключить прогресс-бар LSP
        },
        hover = {
          enabled = false, -- Отключить всплывающие подсказки при наведении
        },
      },
      -- можно включить предустановки для упрощения конфигурации
      presets = {
        bottom_search = false, -- использовать классическую командную строку внизу для поиска
        command_palette = true, -- объединить командную строку и меню автодополнения в одном месте
        long_message_to_split = true, -- длинные сообщения будут отправляться в отдельное окно (split)
        inc_rename = false, -- отключить диалог переименования для inc-rename.nvim
        lsp_doc_border = false, -- не добавлять рамку вокруг документов LSP и подсказок функций
      },
    }

  },
}
