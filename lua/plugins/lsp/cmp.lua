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

      require("luasnip.loaders.from_vscode").lazy_load({
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
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.vscode_snippets_path or "" } })

      luasnip.setup({
        history = true,
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged",
        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        lazy = true,
        event = { "VeryLazy" },
      },
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
      vim.list_extend(opts.sources or {}, {
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
      })

      local cmp = require("cmp")

      opts.window = {
        completion = { border = vim.g.borderStyle, scrolloff = 2 },
        documentation = { border = vim.g.borderStyle, scrolloff = 2 },
      }

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
