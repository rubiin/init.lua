return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        {
          ["css"] = {"prettierd", "prettier"},
          ["go"] = {"goimports", "gofmt"},
          ["graphql"] = {"prettierd", "prettier"},
          ["handlebars"] = {"prettierd", "prettier"},
          ["html"] = {"prettierd", "prettier"},
          ["javascript"] = {"prettierd", "prettier"},
          ["javascriptreact"] = {"prettierd", "prettier"},
          ["json"] = {"prettierd", "prettier"},
          ["jsonc"] = {"prettierd", "prettier"},
          ["less"] = {"prettierd", "prettier"},
          ["lua"] = {"stylua"},
          ["markdown"] = {"prettierd", "prettier"},
          ["markdown.mdx"] = {"prettierd", "prettier"},
          ["sass"] = {"prettierd", "prettier"},
          ["scss"] = {"prettierd", "prettier"},
          ["sh"] = {"shfmt"},
          ["svelte"] = {"prettierd", "prettier"},
          ["typescript"] = {"prettierd", "prettier"},
          ["typescriptreact"] = {"prettierd", "prettier"},
          ["vue"] = {"prettierd", "prettier"},
          ["xml"] = {"prettierd", "prettier"},
          ["yaml"] = {"prettierd", "prettier"}
        }

      },

    },
  },
}
