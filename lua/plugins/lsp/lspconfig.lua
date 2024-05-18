local compare = require("cmp.config.compare")
local user_icons = require("custom.icons")

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

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
    end,
  },
}
