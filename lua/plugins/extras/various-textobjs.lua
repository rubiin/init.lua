local util = require("util")

local M = {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
}

function M.config()
  require("various-textobjs").setup({ useDefaultKeymaps = false })

  util.keymap({ "o", "x" }, "aw", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
  util.keymap({ "o", "x" }, "iw", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
end

return M
