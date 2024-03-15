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
    },
  },
}
