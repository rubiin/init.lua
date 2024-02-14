-- 0.10 , can use native snippets

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

      local status_ok, load_snippets = pcall(require, "luasnip.loaders.from_vscode")
      if not status_ok then
        return
      end

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
      "uga-rosa/cmp-dictionary",
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
      local user_icons = require("custom.icons")

      opts = {
        sources = {
          { name = "nvim_lsp", max_item_count = 20 },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 4, max_item_count = 10 },
          { name = "treesitter" },
          { name = "nvim_lua" },
          {
            name = "dictionary",
            keyword_length = 2,
          },
        },
        completion = {
          completeopt = vim.o.completeopt,
        },
        window = {
          completion = { border = vim.g.border_style, scrolloff = 2 },
          documentation = { border = vim.g.border_style, scrolloff = 2 },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            -- load lspkind icons
            item.kind = string.format(" %s  %s", user_icons.kinds[item.kind], item.kind)

            item.menu = ({
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
              dictionary = "[SPELL]",
            })[entry.source.name]

            local label = item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 50)
            if truncated_label ~= label then
              item.abbr = truncated_label .. "..."
            end

            return item
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

      -- source-specific setup

      require("cmp_dictionary").setup({
        paths = { vim.fn.stdpath("config") .. "/spell/en.utf-8.add" },
      })
    end,
  },
}
