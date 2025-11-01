return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
  },
  init = function()
    Snacks.keymap.set("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "Neogit | Open Neogit", silent = true })
  end,
}
