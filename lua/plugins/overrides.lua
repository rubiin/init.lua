-- this file holds all the overrides from lazyvim config
local constant = require("rubin.constants")

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#45475A", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksPickerTitle", { bg = "#7aa2f7", fg = "#1f2335" })
vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "SnacksPickerList", { bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "SnacksPickerListTitle", { bg = "#9ece6a", fg = "#1f2335" })
vim.api.nvim_set_hl(0, "SnacksPickerInputTitle", { bg = "#f7768e", fg = "#1f2335" })
vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { bg = "#1a1b26", fg = "#45475a" })
vim.api.nvim_set_hl(0, "SnacksPickerInputSearch", { bg = "#f7768e", fg = "#1f2335" })
vim.api.nvim_set_hl(0, "SnacksPickerInput", { bg = "#1a1b26" })

return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    priority = 1000,
    build = ":Copilot auth",
    opts = {
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
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = function(_, opts)
      if not opts.file then
        opts.file = {}
      end
      if not opts.filetype then
        opts.filetype = {}
      end

      opts.file[".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" }
      opts.file["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".nvmrc"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file[".node-version"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file["package.json"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" }
      opts.file["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" }
      opts.file["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" }
      opts.file[".go-version"] = { glyph = "", hl = "MiniIconsBlue" }

      -- for prettier filetypes
      for _, filename in ipairs({
        ".prettierrc",
        ".prettierrc.cjs",
        ".prettierrc.cts",
        ".prettierrc.js",
        ".prettierrc.json",
        ".prettierrc.json5",
        ".prettierrc.mjs",
        ".prettierrc.mts",
        ".prettierrc.toml",
        ".prettierrc.ts",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        "prettier.config.cjs",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.mts",
        "prettier.config.ts",
      }) do
        opts.file[filename] = { glyph = "", hl = "MiniIconsPurple" }
      end

      -- for eslint files

      local eslint_files = {
        -- ESLint <=8 (Deprecated)
        ".eslintignore",
        ".eslintrc",
        ".eslintrc.cjs",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        -- ESLint >=9
        "eslint.config.cjs",
        "eslint.config.cts",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.mts",
        "eslint.config.ts",
      }
      for _, filename in ipairs(eslint_files) do
        opts.file[filename] = { glyph = "󰱺", hl = "MiniIconsYellow" }
      end

      opts.filetype["gotmpl"] = { glyph = "󰟓", hl = "MiniIconsGrey" }
      opts.filetype["postcss"] = { glyph = "󰌜", hl = "MiniIconsOrange" }
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    --- see here for more info https://www.lazyvim.org/plugins/ui#snacksnvim
    opts = {

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
            undoreload = 0,
            undolevels = -1,
            spell = false,
            list = false,
            filetype = "",
          })

          vim.b.minianimate_disable = true
          vim.b.minihipatterns_disable = true
          vim.b.completion = false
          vim.b.minisurround_disable = true
          vim.b.vim.b.miniai_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
          end)
        end,
      },
      dim = { enabled = false },
      input = { enabled = true },
      indent = {
        enabled = true,
      },

      notifier = { enabled = true, timeout = 2000, sort = { "added" } },
      picker = {
        enabled = true,
        layout = {
          -- The default layout for "telescopy" pickers, e.g. `files`, `commands`, ...
          -- It will not override non-standard pickers, e.g. `explorer`, `lines`, ...
          preset = function()
            return vim.o.columns >= 120 and "telescope" or "vertical"
          end,
        },
        layouts = {
          telescope = {
            -- Copy from https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#telescope
            reverse = false,
            layout = {
              box = "horizontal",
              backdrop = false,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.51, -- Change the preview width
                border = "rounded",
                title_pos = "center",
              },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          explorer = {
            hidden = true,
            layout = {
              layout = {
                position = "right",
              },
            },
          },
          lines = {
            layout = {
              preset = function()
                return vim.o.columns >= 120 and "telescope" or "vertical"
              end,
            },
          },
        },
      },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      quickfile = { enabled = true },
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
}
