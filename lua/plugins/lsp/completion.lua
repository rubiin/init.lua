-- 0.10 , can use native snippets

local cmp = require("cmp")
local compare = require("cmp.config.compare")
local user_icons = require("custom.icons")

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")

      -- extend snippets to other filetypes
      luasnip.filetype_extend("typescript", { "tsdoc" })
      luasnip.filetype_extend("javascript", { "jsdoc" })
      luasnip.filetype_extend("lua", { "luadoc" })
      luasnip.filetype_extend("python", { "pydoc" })
      luasnip.filetype_extend("rust", { "rustdoc" })
      luasnip.filetype_extend("sh", { "shelldoc" })

      -- extend html snippets to react files
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      local load_snippets = prequire("luasnip.loaders.from_vscode")

      load_snippets.lazy_load({
        include = {
          "javascript",
          -- "css",
          "docker",
          -- "go",
          -- "html",
          "typescript",
          "json",
          "lua",
          "markdown",
          -- "python",
          -- "rust",
          "shell",
          -- "sql",
        },
      })
      load_snippets.lazy_load({ paths = { vim.g.vscode_snippets_path or "" } })

      luasnip.setup({
        history = true,
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged",
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "f3fora/cmp-spell",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    },
    opts = function(_, opts)
      opts.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
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

    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)

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
