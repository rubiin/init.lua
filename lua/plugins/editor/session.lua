return {
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>qs",
        function()
          require("persisted").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persisted").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persisted").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved,resolves to ~/.local/share/nvim/my-sessions/
      silent = false, -- silent nvim message when sourcing session file
      use_git_branch = false, -- create session files based on the branch of a git enabled repository
      default_branch = "main", -- the branch to load if a session file is not found for the current branch
      autosave = true, -- automatically save session files when exiting Neovim
      autoload = false, -- automatically load the session for the cwd on Neovim startup
      on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
      follow_cwd = true, -- change session file name to match current working directory if it changes
      allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
      ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
      telescope = {
        reset_prompt = true, -- Reset the Telescope prompt after an action?
      },
      should_autosave = function()
        local excluded_filetypes = {
          "alpha",
          "oil",
          "lazy",
          "spectre_panel",
          "",
        }

        for _, filetype in ipairs(excluded_filetypes) do
          if vim.bo.filetype == filetype then
            return false
          end
        end

        return true
      end,
    },
  },
}
