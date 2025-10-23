local linters_by_ft = {
  bash = { "shellcheck" },
  lua = { "selene", "luacheck" },
  sh = { "shellcheck" },
  zsh = { "shellcheck" },
}

local eslint_file_types = { "javascript", "typescript", "javascriptreact", "typescriptreact", "sveltve" }

local P = { "eslint_d" }
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
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        eslint_d = {
          args = {
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
