return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "LazyFile",
  lazy = true,
  config = function()
    require("treesj").setup({})
  end,
}
