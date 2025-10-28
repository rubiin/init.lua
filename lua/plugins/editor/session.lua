return {
  {
    "rmagatti/auto-session", -- auto save session
    event = "VeryLazy",
    keys = {

      { "<leader>qs", "<cmd>AutoSession search<CR>", desc = "Restore session" },
      { "<leader>ql", "<cmd>AutoSession restore<CR>", desc = "Restore Last Session" },
      { "<leader>qd", "<cmd>AutoSession disable<CR>", desc = "Don't Save Current Session" },
    },
    opts = {
      enabled = true, -- Enables/disables auto creating, saving and restoring
      auto_save = true, -- Enables/disables auto saving session on exit
      auto_restore = false, -- Enables/disables auto restoring session on start
      log_level = "error",
      suppressed_dirs = { "/", "~/", "~/Downloads", "~/Documents" },
      use_git_branch = true,
      bypass_save_filetypes = { "snacks_dashboard" },
      cwd_change_handling = true,
      root_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved,resolves to ~/.local/share/nvim/my-sessions/
      session_lens = {
        picker = "snacks",
      },
    },
  },
}
