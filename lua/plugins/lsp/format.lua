local formatters_by_ft = {
  bash = { "shfmt" },
  go = { "goimports", "gofmt" },
  lua = { "stylua" },
  sh = { "shfmt" },
  zsh = { "shfmt" },
}

local utils = require("utils")

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
  "sass",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "xml",
  "yaml",
}

local P = { "biome", "prettierd" }
for _, ft in pairs(prettier_file_types) do
  formatters_by_ft[ft] = P
end

return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = formatters_by_ft,
      formatters = {
        biome = {
          condition = function()
            return utils.cli_config_exists({ "biome.json", "biome.jsonc" })
          end,
        },
        deno_fmt = {
          condition = function()
            return utils.cli_config_exists({ "deno.json" })
          end,
        },
        prettierd = {
          condition = function()
            return not utils.cli_config_exists({ "biome.json", "biome.jsonc" })
              and utils.cli_config_exists({ "prettier.config.js", ".prettierrc", ".prettierrc.json" })
          end,
        },
      },
    },
  },
}
