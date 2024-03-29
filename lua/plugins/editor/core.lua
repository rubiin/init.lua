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
  { "tpope/vim-sleuth", event = "VeryLazy", lazy = true }, -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  { "tpope/vim-repeat", event = "VeryLazy", lazy = true }, -- This plugin enables . repeat support on some plugins
}
