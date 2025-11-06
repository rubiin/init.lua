local constants = require("utils.constants")
local utils = require("utils")

local used_style = constants.styles.bubbly -- this is the default style, change it to the style you want to use from the list

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      return utils.set_lualine_styles(used_style, opts)
    end,
  },
}
