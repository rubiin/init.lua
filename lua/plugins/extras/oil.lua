return {
  "stevearc/oil.nvim",
  event = "BufReadPre",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", desc = "Oil" },
  },
}
