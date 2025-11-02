-- Only load those plugins if the current buffer is a git repository
local util = require("utils")

return {
  {
    "sindrets/diffview.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    event = { "BufReadPre", "BufNewFile" },
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
  -- Git command inside vim
  --TODO: check this plugin
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Git Add" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gpl", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
  },
}
