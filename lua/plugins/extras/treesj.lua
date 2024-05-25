return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "TSJJoin", "TSJSplit" },
  lazy = true,
  config = function()
    require("treesj").setup({})
  end,
}
