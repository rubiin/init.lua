return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = { "TSJJoin", "TSJSplit" },
  lazy = true,
  opts = { use_default_keymaps = false, max_join_length = 150 },
}
