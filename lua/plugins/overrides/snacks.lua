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

          -- TODO: disable highlighturl.nvim

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
        hidden = true,
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
}
