-- 0.10 , can use native snippets
local cmp = require("cmp")
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
      {
        "hrsh7th/cmp-cmdline",
        lazy = true,
        event = { "VeryLazy" },
      },
      {
        "octaltree/cmp-look",
        lazy = true,
        event = { "VeryLazy" },
      },
      {
        "hrsh7th/cmp-nvim-lua",
        lazy = true,
        event = { "VeryLazy" },
      },
      {
        "ray-x/cmp-treesitter",
        lazy = true,
        event = { "VeryLazy" },
      },
    },
    opts = {
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        look = 1,
        cmp_tabnine = 1,
        copilot = 1,
        buffer = 1,
        path = 1,
      },
      sources = {
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "buffer", keyword_length = 4, max_item_count = 10 },
        { name = "luasnip" },
        { name = "path" },
        {
          name = "look",
          keyword_length = 2,
          option = {
            convert_case = true,
            loud = true,
            dict = "/usr/share/dict/words",
          },
        },
        { name = "treesitter" },
        { name = "nvim_lua" },
      },
      completion = {
        completeopt = vim.o.completeopt,
      },

      window = {
        completion = { border = vim.g.border_style, scrolloff = vim.o.scrolloff, scrollbar = "║" },
        documentation = { border = vim.g.border_style, scrolloff = vim.o.scrolloff, scrollbar = "║" },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- load lspkind icons
          item.kind = string.format(" %s  %s", user_icons.kinds[item.kind], item.kind)

          item.menu = ({
            cmp_tabnine = "[tabnine]",
            copilot = "[copilot]",
            buffer = "[buffer]",
            orgmode = "[org]",
            look = "[dictionary]",
            nvim_lsp = "[lsp]",
            nvim_lua = "[lua]",
            path = "[path]",
            tmux = "[tmux]",
            treesitter = "[treesitter]",
            latex_symbols = "[latex]",
            luasnip = "[snippet]",
          })[entry.source.name]

          local label = item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, 50)
          if truncated_label ~= label then
            item.abbr = truncated_label .. "..."
          end

          return item
        end,
      },
    },

    config = function(_, opts)
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
