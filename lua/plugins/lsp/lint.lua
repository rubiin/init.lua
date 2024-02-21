return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- TODO: fix some issue with eslint_d
      linters_by_ft = {
        markdown = { "markdownlint" },
        ["*"] = { "cspell" },
        lua = { "selene" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
      },
    },
  },
}
