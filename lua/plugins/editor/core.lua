local user_icons = require("rubin.icons")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = false, -- lazyvim.config.autocmds
        colorscheme = "catppuccin",
      },
    },
  },
  { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } }, -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  { "tpope/vim-repeat", event = { "BufReadPre", "BufNewFile" } }, -- This plugin enables . repeat support on some plugins
}
