return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = true,
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
