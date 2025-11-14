local constants = require("rubin.constants")
local lualine = require("rubin.lualine")

local used_style = constants.styles.bubbly -- this is the default style, change it to the style you want to use from the list

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      return lualine.set_lualine_styles(used_style, opts)
    end,
  },
}
