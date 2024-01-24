local util = require("utils.helpers")

return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          vim.list_extend(
            opts.ensure_installed or {},
            { "prettier", "prettierd", "goimports", "stylua", "shfmt", "eslint_d", "cspell", "markdownlint" }
          )
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        {
          ["css"] = { "prettierd", "prettier" },
          ["go"] = { "goimports", "gofmt" },
          ["graphql"] = { "prettierd", "prettier" },
          ["handlebars"] = { "prettierd", "prettier" },
          ["html"] = { "prettierd", "prettier" },
          ["javascript"] = { "prettierd", "prettier" },
          ["javascriptreact"] = { "prettierd", "prettier" },
          ["json"] = { "prettierd", "prettier" },
          ["jsonc"] = { "prettierd", "prettier" },
          ["less"] = { "prettierd", "prettier" },
          ["lua"] = { "stylua" },
          ["markdown"] = { "prettierd", "prettier" },
          ["markdown.mdx"] = { "prettierd", "prettier" },
          ["sass"] = { "prettierd", "prettier" },
          ["scss"] = { "prettierd", "prettier" },
          ["sh"] = { "shfmt" },
          ["svelte"] = { "prettierd", "prettier" },
          ["typescript"] = { "prettierd", "prettier" },
          ["typescriptreact"] = { "prettierd", "prettier" },
          ["vue"] = { "prettierd", "prettier" },
          ["xml"] = { "prettierd", "prettier" },
          ["yaml"] = { "prettierd", "prettier" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = util.extend_keys(opts.linters_by_ft, { "*" }, { "cspell" })
    end,
  },
}
