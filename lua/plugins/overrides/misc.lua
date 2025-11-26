-- this file holds all the overrides from lazyvim config
local constant = require("rubin.constants")

return {
  {
    "zbirenbaum/copilot.lua",
    event = "BufReadPost",
    opts = {
      event = "InsertEnter",
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = "off",
          },
        },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      {
        "<leader>hh",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Toggle menu",
      },
      {
        "<leader>ha",
        function()
          require("harpoon"):list():append()
        end,
        desc = "Add File",
      },
      {
        "<leader>hc",
        function()
          require("harpoon"):list():clear()
        end,
        desc = "Clear All",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Next File",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Previous File",
      },
    },
  },

  {
    "monaqa/dial.nvim",
    opts = function(_, opts)
      local augend = require("dial.augend")
      local environments = augend.constant.new({
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = { "production", "development", "stage", "test", "sandbox" },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      })
      local logs = augend.constant.new({
        elements = { "fatal", "error", "warn", "info", "debug", "trace" },
        word = false,
        cyclic = true,
      })

      opts.groups.default = vim.list_extend(opts.groups.default, {
        environments,
        logs,
        augend.integer.alias.Bool,
        augend.constant.alias.en_weekday_full,
        augend.case.new({
          types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
          cyclic = true,
        }),
      })
    end,
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    opts = {
      keys = {
        ["<Tab>"] = "next",
        ["<S-Tab>"] = "prev",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>uB",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle Git Line Blame",
      },
    },
    opts = {
      current_line_blame = true,
      attach_to_untracked = true,
      max_file_length = 12000, -- lines
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = { {
      "<leader>bb",
      "<cmd>BufferLinePick<cr>",
      desc = "Pick buffer",
    } },
  },
  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = vim.g.border_style,

      filesystem = {
        window = {
          mappings = {
            ["o"] = "system_open",
          },
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end,
      },
    },
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      auto_integrations = true,
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = vim.g.border_style,
          draw = {
            columns = { { "kind_icon", "label", gap = 2 }, { "label_description", "kind" } },
          },
        },
      },
    },
  },
}

-- TODO: check the hover doc issue
