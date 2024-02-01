-- 0.10 , can use native snippets
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip").filetype_extend("typescript", { "tsdoc" })
        require("luasnip").filetype_extend("javascript", { "jsdoc" })
        require("luasnip").filetype_extend("lua", { "luadoc" })
        require("luasnip").filetype_extend("python", { "pydoc" })
        require("luasnip").filetype_extend("rust", { "rustdoc" })
        require("luasnip").filetype_extend("sh", { "shelldoc" })

        -- extend html snippets to react files
        require("luasnip").filetype_extend("javascriptreact", { "html" })
        require("luasnip").filetype_extend("typescriptreact", { "html" })

        require("luasnip.loaders.from_vscode").lazy_load({
          include = {
            "javascript",
            "css",
            "docker",
            "go",
            "html",
            "typescript",
            "json",
            "lua",
            "markdown",
            "python",
            "rust",
            "shell",
            "sql",
          },
        })
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.vscode_snippets_path or "" } })
      end,
    },
    opts = {
      history = true,
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        event = "InsertEnter",
      },
      {
        "hrsh7th/cmp-cmdline",
        event = "InsertEnter",
      },
      {
        "hrsh7th/cmp-nvim-lua",
        event = "InsertEnter",
      },
    },
    opts = function(_, opts)
      vim.list_extend(opts.sources or {}, {
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
      })

      local cmp = require("cmp")

      opts.window = {
        documentation = cmp.config.window.bordered(),
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
