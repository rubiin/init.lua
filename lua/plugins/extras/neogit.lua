return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  init = function()
    Snacks.keymap.set("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "Neogit | Open Neogit", silent = true })
  end,
}
