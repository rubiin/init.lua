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

      zen = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 2000 },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      indent = {
        enabled = true,

        -- filter for buffers to enable indent guides
        filter = function()
          return vim.g.snacks_indent ~= false
            and vim.b[buf].snacks_indent ~= false
            and vim.bo[buf].buftype == ""
            and not utils.list_contains(constant.common_file_types, vim.bo[buf].filetype)
        end,
      },
    },
  },
}
