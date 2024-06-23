local compare = require("cmp.config.compare")
local user_icons = require("rubin.icons")

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true, search_paths = { vim.g.vscode_snippets_path } } },
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }
      -- Set view to follow cursor while typing
      opts.view = {
        entries = {
          follow_cursor = true,
        },
      }

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        copilot = 1,
        buffer = 1,
        path = 1,
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
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      --
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
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
    end,
  },
}
