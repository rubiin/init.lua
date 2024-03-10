local user_icons = require("custom.icons")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = false, -- lazyvim.config.autocmds
        keymaps = true, -- lazyvim.config.keymaps
        colorscheme = "catppuccin",
      },
      ui = {
        icons = {
          loaded = user_icons.ui.Loaded,
          not_loaded = user_icons.ui.NotLoaded,
        },
        border = vim.g.border_style,
      },
    },
  },
}
