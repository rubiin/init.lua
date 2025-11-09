local utils = require("utils")

local linters_by_ft = {
  bash = { "shellcheck" },
  lua = { "selene", "luacheck" },
  sh = { "shellcheck" },
  zsh = { "shellcheck" },
}

local eslint_file_types = { "javascript", "typescript", "javascriptreact", "typescriptreact", "sveltve" }

local P = { "oxlint", "eslint_d" }
for _, ft in pairs(eslint_file_types) do
  linters_by_ft[ft] = P
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = linters_by_ft,
      linters = {
        selene = {
          condition = function()
            return utils.cli_config_exists({ "selene.toml" })
          end,
        },
        luacheck = {
          condition = function()
            return utils.cli_config_exists({ ".luacheckrc" })
          end,
        },
        oxlint = {
          condition = function()
            return utils.cli_config_exists({ ".oxlintrc.json" })
          end,
        },
        eslint_d = {
          condition = function()
            return utils.cli_config_exists({
              ".eslintrc",
              ".eslintrc.json",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
            })
          end,
          args = {
            "--no-warn-ignored",
            "--format",
            "--cache",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
              return vim.api.nvim_buf_get_name(0)
            end,
          },
        },
      },
    },
  },
}
