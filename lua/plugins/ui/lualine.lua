local constants = require("utils.constants")
local utils = require("utils")

local used_style = constants.styles.bubbly -- this is the default style, change it to the style you want to use from the list
local lualine_styles = utils.set_lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = lualine_styles,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local trouble = require("trouble")
      if not trouble.statusline then
        LazyVim.error("You have enabled the **trouble-v3** extra,\nbut still need to update it with `:Lazy`")
        return
      end

      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
      })
      table.insert(opts.winbar.lualine_a, {
        symbols.get,
        cond = symbols.has,
      })
    end,
  },
}
