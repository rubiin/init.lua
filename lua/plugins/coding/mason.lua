return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = "",
          package_pending = "➜",
          package_uninstalled = ""
        }
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
