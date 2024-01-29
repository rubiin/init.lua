return {
  "karb94/neoscroll.nvim",
  event = "BufRead",
  lazy = true,
  opts = {

    mappings = { "<C-u>", "<C-d>" }, -- disable other scrolling methods
  },
}
