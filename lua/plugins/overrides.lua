-- this file holds all the overrides from lazyvim config
local constant = require("utils.constants")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      defaults = {
        autocmds = false,
      },
    },
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
    opts = {
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      style = "night",
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
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.health = {
        checker = true, -- Disable if you don't want health checks to run
      }
      opts.signature = {
        enabled = false,
      }
      local routes = { -- REDIRECT TO MINI
        -- write/deletion messages
        {
          filter = {
            event = "msg_show",
            find = "%d+B written$",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%d+B written$",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%d fewer lines",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%d more lines",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%d lines yanked",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B$",
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            find = "%-%-No lines in buffer%-%-",
          },
          view = "mini",
        }, -- unneeded info on search patterns
        {
          filter = {
            event = "msg_show",
            find = "^E486: Pattern not found",
          },
          view = "mini",
        }, -- Word added to spellfile via `zg`
        {
          filter = {
            event = "msg_show",
            find = "^Word .*%.add$",
          },
          view = "mini",
        }, -- nvim-treesitter
        {
          filter = {
            event = "msg_show",
            find = "^%[nvim%-treesitter%]",
          },
          view = "mini",
        },
        {
          filter = {
            event = "notify",
            find = "^%[Neo%-tree INFO%] Toggling hidden files.*",
          },
          skip = true,
        },
        { -- Mason
          filter = {
            event = "notify",
            cond = function(msg)
              return msg.opts and (msg.opts.title or ""):find("mason")
            end,
          },
          view = "mini",
        }, -----------------------------------------------------------------------------
        -- SKIP
        -- FIX LSP bugs?
        {
          filter = {
            event = "msg_show",
            find = "lsp_signature? handler RPC",
          },
          skip = true,
        },
        {
          filter = {
            event = "msg_show",
            find = "^%s*at process.processTicksAndRejections",
          },
          skip = true,
        }, -- code actions
        {
          filter = {
            event = "notify",
            find = "No code actions available",
          },
          skip = true,
        },
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },
      }

      for _, value in ipairs(routes) do
        table.insert(opts.routes, value)
      end

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
        opts = {
          stop = false,
        },
      })
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = {
            enter = true,
            format = "details",
          },
          filter = {},
        },
      }

      opts.views = {
        cmdline_popup = {
          border = {
            style = vim.g.border_style,
          },
        },
        hover = {
          border = {
            style = vim.g.border_style,
          },
        },
        popup = {
          border = {
            style = vim.g.border_style,
          },
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
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    --- see here for more info https://www.lazyvim.org/plugins/ui#snacksnvim
    opts = {

      dim = { enabled = false },
      bigfile = {
        size = 500 * 1024, -- 500KB
        setup = function(ctx)
          if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
          end
          Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })

          -- taken from lunarvim/bigfile.nvim
          vim.cmd("syntax clear")
          Snacks.util.wo(0, {
            syntax = "OFF",
            swapfile = false,
            foldmethod = "manual",
            undolevels = -1,
            undoreload = 0,
            list = false,
            filetype = "",
          })

          vim.b.minianimate_disable = true
          vim.b.minihipatterns_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
          end)
        end,
      },
      input = { enabled = true },
      indent = {
        enabled = true,
      },
      picker = {
        enabled = true,
        layout = "telescope",
      },
      notifier = { enabled = true, timeout = 2000 },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      quickfile = { enabled = true },
      zen = { enabled = false },
    },
  },
}
