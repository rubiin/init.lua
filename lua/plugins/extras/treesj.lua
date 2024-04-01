return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPre",
  lazy = true,
  config = function()
    require("treesj").setup({})
  end,
}
