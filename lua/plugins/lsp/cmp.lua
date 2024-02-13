local sourceIcons = {
  buffer = "󰽙",
  cmdline = "󰘳",
  emoji = "󰞅",
  luasnip = "",
  nvim_lsp = "󰒕",
  path = "",
  nvim_lua = "",
  treesitter = "",
  zsh = "",
  spell = "暈",
}
-- 0.10 , can use native snippets

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")

      luasnip.filetype_extend("typescript", { "tsdoc" })
      luasnip.filetype_extend("javascript", { "jsdoc" })
      luasnip.filetype_extend("lua", { "luadoc" })
      luasnip.filetype_extend("python", { "pydoc" })
      luasnip.filetype_extend("rust", { "rustdoc" })
      luasnip.filetype_extend("sh", { "shelldoc" })

      -- extend html snippets to react files
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      local load_snippets = require("luasnip.loaders.from_vscode")

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
        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "ray-x/cmp-treesitter", commit = "c8e3a74" },
      { "f3fora/cmp-spell" },
      {
        "hrsh7th/cmp-cmdline",
        lazy = true,
        event = { "VeryLazy" },
      },
      {
        "hrsh7th/cmp-nvim-lua",
        lazy = true,
        event = { "VeryLazy" },
      },
    },
    opts = function(_, opts)
      opts.sources = {
        { name = "nvim_lsp", max_item_count = 350 },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "treesitter" },
        { name = "spell" },
        { name = "buffer" },
      }

      local user_icons = require("custom.icons")

      opts = {
        completion = {
          completeopt = vim.o.completeopt,
        },
        window = {
          completion = { border = vim.g.border_style, scrolloff = 2 },
          documentation = { border = vim.g.border_style, scrolloff = 2 },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind =
              string.format(" %s  %s", user_icons.kinds[vim_item.kind] or user_icons.kinds.Null, vim_item.kind or "")

            vim_item.menu = setmetatable({
              cmp_tabnine = "[TN]",
              copilot = "[CPLT]",
              buffer = "[BUF]",
              orgmode = "[ORG]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[LUA]",
              path = "[PATH]",
              tmux = "[TMUX]",
              treesitter = "[TS]",
              latex_symbols = "[LTEX]",
              luasnip = "[SNIP]",
              spell = "[SPELL]",
            }, {
              __index = function()
                return "[BTN]" -- builtin/unknown source names
              end,
            })[entry.source.name]

            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 80)
            if truncated_label ~= label then
              vim_item.abbr = truncated_label .. "..."
            end

            return vim_item
          end,
        },
      }
    end,

    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)
      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
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
