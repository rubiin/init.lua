return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = true,
  config = function()
    require("treesj").setup({})
  end,
}
