return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
