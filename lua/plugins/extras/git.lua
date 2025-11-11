-- Only load those plugins if the current buffer is a git repository
local util = require("utils")

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    event = "LazyFile",
    opts = {
      default_mappings = false,
      disable_diagnostics = true,
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
      { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
      { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
    },
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit | Open Neogit" },
    },
  },
}
