local icons = require("utils.icons")

return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "VeryLazy",
  lazy = true,
  opts = {
    keywords = {
      FIX = {
        icon = icons.ui.Bug, -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      },
      TODO = { icon = icons.ui.BoxChecked, color = "info" },
      HACK = { icon = icons.ui.Fire, color = "warning" },
      WARN = { icon = icons.diagnostics.Warn, color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.ui.Gear, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.ui.Note, color = "hint", alt = { "INFO" } },
      TEST = {
        icon = icons.ui.Target,
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },
    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
  },
}
