local util = require("utils")

local M = {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
}

function M.config()
  require("various-textobjs").setup({ useDefaultKeymaps = false })

  util.keymap({ "o", "x" }, "aw", function()
    require("various-textobjs").subword("outer")
  end, { desc = "" })

  util.keymap({ "o", "x" }, "iw", function()
    require("various-textobjs").subword("inner")
  end, { desc = "" })
end

return M
