-- this file holds all the overrides from lazyvim config
local constant = require("utils.constants")

return {
  {
    "echasnovski/mini.indentscope",
    opts = {
      scroll = {
        enable = false,
      },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
  {
    "echasnovski/mini.animate",
    opts = {
      cursor = {
        enable = false,
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
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    },
    opts = {
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
  -- project
  {
    "ahmedkhalf/project.nvim",
    lazy = false,

    opts = {
      manual_mode = false,
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "pyproject.toml",
        "poetry.lock",
        "go.mod",
        "Cargo.lock",
      },
    },
  },
  -- nvim-notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      -- Animation style
      stages = "fade_in_slide_out",
    },
  },
  -- neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = vim.g.border_style,
    },
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = constant.common_file_types,
    },
  },

  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.health = {
        checker = true, -- Disable if you don't want health checks to run
      }
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          event = "msg_show",
          find = "%d+L, %d+B",
          cond = function()
            return not focused
          end,
        },
        view = "mini",
        opts = { stop = false },
      })
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },
}
