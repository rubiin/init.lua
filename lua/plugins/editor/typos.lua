return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "typos-lsp" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          settings = {
            diagnosticSeverity = "Warning",
          },
        },
      },
    },
  },
   {
    "aznhe21/actions-preview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    -- TOD): fix this keymaps
    keys = {
      {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "Show code for current line",
      },
      {
        "<leader>cA",
        function()
          require("actions-preview").code_actions({ context = { only = { "source" } } })
        end,
        desc = "Show for current buffer",
      },
    },
    config = function()
      require("actions-preview").setup({
        diff = {
          algorithm = "patience",
          ignore_whitespace = true,
        },
        telescope = require("telescope.themes").get_dropdown({
          winblend = 10,
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, maxln)
              return maxln - 15
            end,
          },
        }),
      })
    end,
  }
}
