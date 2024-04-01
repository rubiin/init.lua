-- Only load those plugins if the current buffer is a git repository
local util = require("utils")

return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    init = function()
      require("git-conflict").setup({
        default_mappings = false,
        disable_diagnostics = true,
      })
    end,
    keys = {
      { "<leader>gco", ":GitConflictChooseOurs<cr>" },
      { "<leader>gct", ":GitConflictChooseTheirs<cr>" },
      { "<leader>gcb", ":GitConflictChooseBoth<cr>" },
      { "<leader>gc0", ":GitConflictChooseNone<cr>" },
      { "]x", ":GitConflictNextConflict<cr>" },
      { "[x", ":GitConflictPrevConflict<cr>" },
    },
  },
  -- Git command inside vim
  --TODO: check this plugin
  {
    "tpope/vim-fugitive",
    event = "BufReadPre",
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Git Add" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
      { "<leader>gpl", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
  },
}
