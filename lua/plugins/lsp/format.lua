return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      formatters_by_ft = {
        bash = { "shfmt" },
        css = { "biome", "prettierd", "prettier" },
        go = { "goimports", "gofmt" },
        graphql = { "biome", "prettierd", "prettier" },
        handlebars = { "biome", "prettierd", "prettier" },
        html = { "biome", "prettierd", "prettier" },
        javascript = { "biome", "deno_fmt", "prettier" },
        javascriptreact = { "rustywind", "biome", "deno_fmt", "prettierd" },
        json = { "biome", "prettierd", "prettier" },
        jsonc = { "biome", "prettierd", "prettier" },
        less = { "biome", "prettierd", "prettier" },
        lua = { "stylua" },
        markdown = { "biome", "prettierd", "prettier" },
        sass = { "biome", "prettierd", "prettier" },
        scss = { "biome", "prettierd", "prettier" },
        sh = { "shfmt" },
        svelte = { "rustywind", "biome", "deno_fmt", "prettierd", "prettier" },
        typescript = { "biome", "deno_fmt", "prettierd", "prettier" },
        typescriptreact = { "rustywind", "biome", "deno_fmt", "prettierd", "prettier" },
        vue = { "biome", "prettierd", "prettier" },
        xml = { "biome", "prettierd", "prettier" },
        yaml = { "biome", "prettierd", "prettier" },
        zsh = { "shfmt" },
      },
      formatters = {
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        deno_fmt = {
          condition = function(ctx)
            return vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          prepend_args = {
            "--cache",
          },
          condition = function(ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
              and not vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettierd = {
          prepend_args = {
            "--cache",
          },
          condition = function(ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
              and not vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
