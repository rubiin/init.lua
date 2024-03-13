-- Only load those plugins if the current buffer is a git repository
local util = require("utils")

return {
  {
    "sindrets/diffview.nvim",
    lazy = not util.is_git_repo(),
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff" } },
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = not util.is_git_repo(),
    event = "VeryLazy",
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
}
