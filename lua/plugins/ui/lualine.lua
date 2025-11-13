local constants = require("utils.constants")
local lualine = require("utils.lualine")

local used_style = constants.styles.slanted_reverse -- this is the default style, change it to the style you want to use from the list

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      return lualine.set_lualine_styles(used_style, opts)
    end,
  },
}
