return {

  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  event = "LspAttach",
  opts = {
    --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
    backend = "delta",

    -- The picker to use, "telescope", "snacks", "select", "buffer", "fzf-lua" are supported
    -- And it's opts that will be passed at the picker's creation, optional
    --
    -- You can also set `picker = "<picker>"` without any opts.
    picker = "snacks",
    backend_opts = {
      delta = {
        args = {
          "--config=" .. os.getenv("HOME") .. "/.config/git/gitconfig",
        },
      },
    },

    resolve_timeout = 100, -- Timeout in milliseconds to resolve code actions

    -- Notification settings
    notify = {
      enabled = true, -- Enable/disable all notifications
      on_empty = true, -- Show notification when no code actions are found
    },

    -- The icons to use for the code actions
    -- You can add your own icons, you just need to set the exact action's kind of the code action
    -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
    signs = {
      quickfix = { "", { link = "DiagnosticWarning" } },
      others = { "", { link = "DiagnosticWarning" } },
      refactor = { "", { link = "DiagnosticInfo" } },
      ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
      ["refactor.extract"] = { "", { link = "DiagnosticError" } },
      ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
      ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
      ["source"] = { "", { link = "DiagnosticError" } },
      ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
      ["codeAction"] = { "", { link = "DiagnosticWarning" } },
    },
  },
  keys = {
    {
      "<leader>cP",
      function()
        require("tiny-code-action").code_action({})
      end,
      desc = "Code Action Preview",
    },
  },
}
