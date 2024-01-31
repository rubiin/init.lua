-- this file holds all the small plugin changes or overides from lazyvim config

return {

  -- profiling vim startup
  {
    enabled = false,
    lazy = true,
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
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

  -- wakatime
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    lazy = true,
  },
  -- project
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
    },
  },
  -- zoom
  {
    "echasnovski/mini.misc",
    config = true,
    lazy = true,
    event = "VeryLazy",
    --stylua: ignore
    keys = {
      {
        '<leader>uz',
        function()
          require('mini.misc').zoom()
        end,
        desc = 'Toggle Zoom'
      }
    }
,
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
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    lazy = true,
    cmd = "CellularAutomaton",
  },
}
