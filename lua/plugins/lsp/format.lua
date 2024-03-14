local formatters_by_ft = {
  bash = { "shfmt" },
  go = { "goimports", "gofmt" },
  lua = { "stylua" },
  toml = { "taplo" },
  sh = { "shfmt" },
  zsh = { "shfmt" },
}

local prettier_file_types = {
  "angular",
  "css",
  "flow",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "sass",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "xml",
  "yaml",
}

local P = { "biome", "prettierd", "prettier" }
for _, ft in pairs(prettier_file_types) do
  formatters_by_ft[ft] = P
end

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
      formatters_by_ft = formatters_by_ft,
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
