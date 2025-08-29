local utils = require("utils")
local constant = require("utils.constants")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    --- see here for more info https://www.lazyvim.org/plugins/ui#snacksnvim
    opts = {

      dim = { enabled = false },
      bigfile = { enabled = true },
      input = { enabled = true },
      indent = {
        enabled = true,
      },
      notifier = { enabled = true, timeout = 2000 },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      quickfile = { enabled = true },
      zen = { enabled = false },
    },
  },
}
