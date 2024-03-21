local constants = require("utils.constants")
local utils = require("utils")

local used_style = constants.styles.bubbly -- this is the default style, change it to the style you want to use from the list
local lualine_styles = utils.set_lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = lualine_styles,
  },
}
