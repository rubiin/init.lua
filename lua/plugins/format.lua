
  return {
    -- Setup config for formatter
    {
      "stevearc/conform.nvim",
      optional = true,
      keys = {
        -- Add keymap for show info
        { "<leader>cn", "<cmd>ConformInfo<cr>", desc = "Conform Info" },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          go = { "goimports", "gofmt" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          sass = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          jsonc = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          vue = { "prettierd", "prettier" },
          svelte = { "prettierd", "prettier" },
          xml = { "prettierd", "prettier" }
        },
      },
    },
  }
