return {
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    opts = function()
      local kind_icons = vim.tbl_map(function(icon)
        return vim.trim(icon)
      end, require("lazyvim.config").icons.kinds)
      return {
        theme = "catppuccin",
        show_modified = true,
        kinds = kind_icons,
        create_autocmd = false,
      }
    end,
  },
}
