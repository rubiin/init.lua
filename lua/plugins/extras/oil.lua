return {
  "stevearc/oil.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
