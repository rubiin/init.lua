return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  lazy = true,
  config = function()
    require("treesj").setup({})
  end,
}
