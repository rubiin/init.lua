-- 0.10 , can use native snippets

local compare = require("cmp.config.compare")
local user_icons = require("custom.icons")

local cmp = require("cmp")

return {

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "f3fora/cmp-spell",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
    },
    opts = function(_, opts)
      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      opts.duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        look = 1,
        cmp_tabnine = 1,
        copilot = 1,
        buffer = 1,
        path = 1,
      }
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
        {
          name = "spell",
          group_index = 2,
          option = {
            keep_all_entries = false,
            enable_in_context = function()
              return true
            end,
          },
        },
        { name = "nvim_lua" },
      }
      opts.completion = {
        completeopt = vim.o.completeopt,
      }
      opts.sorting = {
        comparators = {
          -- Original order: https://github.com/hrsh7th/nvim-cmp/blob/538e37ba87284942c1d76ed38dd497e54e65b891/lua/cmp/config/default.lua#L65-L74
          -- Definitions of compare function https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
          compare.offset,
          compare.recently_used, -- higher
          compare.score,
          compare.exact, -- lower
          compare.kind, -- higher (prioritize snippets)
          compare.locality,
          compare.length,
          compare.order,
        },
      }
      opts.window = {
        completion = { border = vim.g.border_style, scrolloff = vim.o.scrolloff, scrollbar = "║" },
        documentation = { border = vim.g.border_style, scrolloff = vim.o.scrolloff, scrollbar = "║" },
        preview = { border = vim.g.border_style, scrolloff = vim.o.scrolloff, scrollbar = "║" },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- load lspkind icons
          item.kind = string.format(" %s  %s", user_icons.kinds[item.kind], item.kind)

          item.menu = ({
            cmp_tabnine = "[Tabnine]",
            copilot = "[Copilot]",
            spell = "[Spell]",
            buffer = "[Buffer]",
            orgmode = "[Org]",
            look = "[Dictionary]",
            nvim_lsp = "[LSP]",
            git = "[Git]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            tmux = "[Tmux]",
            latex_symbols = "[Latex]",
            luasnip = "[Snippet]",
          })[entry.source.name]

          local label = item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, 50)
          if truncated_label ~= label then
            item.abbr = truncated_label .. "..."
          end

          return item
        end,
      }

      table.insert(opts.sources, #opts.sources + 1, {
        name = "git",
        priority = 500,
        group_index = 1,
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      -- LUA: disable annoying `--#region` suggestions
      cmp.setup.filetype("lua", {
        enabled = function()
          local line = vim.api.nvim_get_current_line()
          return not (line:find("%s%-%-?$") or line:find("^%-%-?$"))
        end,
      })

      -- SHELL: disable `\[` suggestions at EoL
      cmp.setup.filetype("sh", {
        enabled = function()
          local col = vim.fn.col(".") - 1
          local charBefore = vim.api.nvim_get_current_line():sub(col, col)
          return charBefore ~= "\\"
        end,
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", max_item_count = 3, keyword_length = 2 },
        },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
