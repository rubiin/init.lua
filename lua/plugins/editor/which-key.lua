return {
  -- which key integration
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = {
        border = vim.g.border_style,
      },
      spec = {
        ["<leader>h"] = { name = "harpoon" },
        ["<leader>l"] = { name = "lsp" },
        ["<leader>;"] = { name = "info" },
        ["<leader>y"] = { name = "misc" },
        ["<leader>T"] = { name = "terminal" },
      },
    },
  },
}
