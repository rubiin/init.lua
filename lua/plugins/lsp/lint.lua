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
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
        oxlint = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".oxlintrc.json" }, { path = root, upward = true })[1]
          end,
        },
        eslint_d = {
          condition = function(ctx)
            utils.eslint_config_exists()
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
