local user_icons = require("custom.icons")

return {
  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      window = {
        border = vim.g.border_style,
      },
      icons = {
        group = "", -- symbol prepended to a group
      },
      defaults = {
        ["<leader>b"] = { name = user_icons.ui.Buffer .. "buffer" },
        ["<leader>c"] = { name = user_icons.ui.Code .. "code" },
        ["<leader>d"] = { name = user_icons.diagnostics.DebugBold .. "debug" },
        ["<leader>f"] = { name = user_icons.ui.FindFile .. "file/find" },
        ["<leader>g"] = { name = user_icons.git.Git .. "git" },
        ["<leader>h"] = { name = user_icons.ui.Harpoon .. "harpoon" },
        ["<leader>l"] = { name = user_icons.ui.Lsp .. "lsp" },
        ["<leader>q"] = { name = user_icons.ui.Quit .. "quit/session" },
        ["<leader>s"] = { name = user_icons.ui.Search .. "search" },
        ["<leader>t"] = { name = user_icons.ui.Test .. "test" },
        ["<leader>u"] = { name = user_icons.ui.Color .. "ui" },
        ["<leader>w"] = { name = user_icons.ui.Window .. "windows" },
        ["<leader>x"] = { name = user_icons.ui.QuickFix .. "diagnostics/quickfix" },
        ["<leader>;"] = { name = user_icons.diagnostics.BoldInfo .. "info" },
        ["<leader>y"] = { name = user_icons.ui.Tools .. "misc" },
        ["<leader>T"] = { name = user_icons.ui.Terminal .. "terminal" },
        ["<leader>r"] = { name = user_icons.ui.Refactor .. "refactoring" },
      },
    },
  },
}
