local icons = require("utils.icons").ui
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = icons.Loaded,
          package_pending = icons.Pending,
          package_uninstalled = icons.NotLoaded,
        },
      }

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
