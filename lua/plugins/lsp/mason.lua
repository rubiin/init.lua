local icons = require("utils.icons")
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = icons.ui.Loaded,
          package_pending = icons.ui.Pending,
          package_uninstalled = icons.ui.NotLoaded,
        },
        border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      }

      opts.max_concurrent_installers = 10
      vim.list_extend(opts.ensure_installed or {}, {
        "goimports",
        "stylua",
        "shfmt",

        -- formatters
        "eslint_d",
        "prettier",
        "prettierd",
        "prettierd",
        "biome",

        -- code spell
        "codespell",
        "cspell",
        "typos-lsp",

        -- markdown
        "markdownlint",
        -- rustywind for tailwindcss
        "rustywind",
      })
    end,
  },
}
