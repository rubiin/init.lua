return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- TODO: fix some issue with eslint_d
      linters_by_ft = {
        markdown = { "markdownlint" },
        lua = { "selene" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
      },
    },
    init = function()
      local eslint_d = require('lint').linters.eslint_d
      eslint_d.args = {
        "--cache"
      }
    end,
  },
}
