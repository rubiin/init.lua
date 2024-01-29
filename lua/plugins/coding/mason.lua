local icons = require("utils.icons")
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = icons.loaded,
          package_pending = icons.pending,
          package_uninstalled = icons.not_loaded,
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
        "misspell",
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
