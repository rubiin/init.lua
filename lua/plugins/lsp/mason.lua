local user_icons = require("custom.icons")

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = user_icons.ui.Loaded,
          package_pending = user_icons.ui.Pending,
          package_uninstalled = user_icons.ui.NotLoaded,
        },
        border = vim.g.border_style,
        height = 0.8,
      }

      opts.max_concurrent_installers = 10
      vim.list_extend(opts.ensure_installed or {}, {
        "goimports",
        "stylua",
        "shfmt",

        -- formatters & linters
        "eslint_d",
        "prettier",
        "prettierd",
        "biome",
        "selene",

        -- code spell
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
