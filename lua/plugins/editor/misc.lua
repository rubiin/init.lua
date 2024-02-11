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
  -- nvim notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      -- Animation style
      stages = "fade_in_slide_out",
    },
  },
  -- neo tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = vim.g.border_style,
    },
  },

  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirvish",
        "oil",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    },
  },
}
