local user_icons = require("custom.icons")

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  keys = {
    {
      "<leader>sT",
      "<cmd>TodoTelescope keywords=TODO,FIX,WARN,HACK,PERF,NOTE,TEST<cr>",
      desc = "Search Todos (Telescope)",
    },
    {
      "<leader>xT",
      "<cmd>TodoTrouble keywords=TODO,FIX,WARN,HACK,PERF,NOTE,TEST<cr>",
      desc = "Search Todos (Trouble)",
    },
  },
  opts = {
    keywords = {
      FIX = {
        icon = user_icons.ui.Bug, -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      },
      TODO = { icon = user_icons.ui.BoxChecked, color = "info" },
      HACK = { icon = user_icons.ui.Fire, color = "warning" },
      WARN = { icon = user_icons.diagnostics.Warn, color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = user_icons.ui.Performance, color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = user_icons.ui.Note, color = "hint", alt = { "INFO" } },
      TEST = {
        icon = user_icons.ui.Test,
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },
    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = true, -- enable multiline todo comments
      multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  },
}
