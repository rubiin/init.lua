local lualine_styles = require('utils.helpers').lualine_styles

local used_style = require('utils.helpers').styles.slanted -- this is the default style, change it to the style you want to use from the list

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    lazy = true,
    opts = lualine_styles(used_style),
  },
}
