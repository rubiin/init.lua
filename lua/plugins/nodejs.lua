return {
  {
    "David-Kunz/cmp-npm",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json",
    config = function()
      require("cmp-npm").setup({})
    end
  },
  {
    "marilari88/twoslash-queries.nvim",
    event = "InsertEnter",
    config = function()
      require("twoslash-queries").setup({});
      require("lspconfig")["tsserver"].setup({
        on_attach = function(client, bufnr)
          require("twoslash-queries").attach(client, bufnr)
        end,
      })
    end,
  }
}
