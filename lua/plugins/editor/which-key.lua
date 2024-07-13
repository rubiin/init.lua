return {
  -- which key integration
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        border = vim.g.border_style,
      },
      icons = {
        group = "", -- symbol prep pended to a group
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
