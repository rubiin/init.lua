return {
  { "folke/persistence.nvim", enabled = false },
  {
    "olimorris/persisted.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persisted").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persisted").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persisted").stop() end, desc = "Don't Save Current Session" },
      {
        "<leader>fs",
        "<cmd>Telescope persisted<cr>",
        desc = "Find Session",
      },
    },
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted")
    end,
  },
}
