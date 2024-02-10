-- this file holds all the overrides from lazyvim config

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
  -- project
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    opts = {
      manual_mode = false,
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      -- Animation style
      stages = "fade_in_slide_out",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = vim.g.border_style,
    },
  },
}
