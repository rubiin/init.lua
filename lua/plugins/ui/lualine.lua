local utils = require("utils")

local used_style = utils.styles.bubbly -- this is the default style, change it to the style you want to use from the list
local lualine_styles = utils.lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    lazy = true,
    opts = lualine_styles,
  },
}
